settings {
    -- inotifyMode: 指定inotify监控的事件，默认是CloseWrite，还可以是Modify或CloseWrite or Modify
    -- insist: keep running at startup although one or more targets failed due to not being reachable.
    insist=true,
    -- logfile: 定义日志文件
    logfile = "/var/log/lsyncd/lsyncd.log",
    -- maxProcesses: 同步进程的最大个数。假如同时有20个文件需要同步，而maxProcesses = 8，则最大能看到有8个rysnc进程
    maxProcesses = 1,
    -- maxDelays: 累计到多少所监控的事件激活一次同步，即使后面的delay延迟时间还未到
    --maxDelays = 1,
    -- nodaemon=true 表示不启用守护模式，默认
    nodaemon = true,
    pidfile = "/var/run/lsyncd.pid",
    -- stausFile: 定义状态文件
    statusFile = "/var/log/lsyncd/lsyncd.status",
    -- statusInterval: 将lsyncd的状态写入上面的statusFile的间隔，默认10秒
    statusInterval = 10,
}

sourceLists = require('/etc/lsyncd/conf.d/pihizi-sources')

for sourceKey,sourceInfo in pairs(sourceLists) do
	passwordFile = "/etc/lsyncd/conf.d/rsync."..sourceKey..".password"
	fh = io.open(passwordFile, 'w')
	fh:write(sourceInfo['password'])
	fh:close()
	sync {
		-- https://axkibe.github.io/lsyncd/manual/config/layer4/
		default.rsync,
		-- source: 同步的源目录，使用绝对路径。
		source = sourceInfo['source'],
		-- target: 定义目的地址.对应不同的模式有几种写法
		--  /tmp/dest ：本地目录同步，可用于direct和rsync模式
		--  172.29.88.223:/tmp/dest ：同步到远程服务器目录，可用于rsync和rsyncssh模式，拼接的命令类似于/usr/bin/rsync -ltsd --delete --include-from=- --exclude=* SOURCE TARGET，剩下的就是rsync的内容了，比如指定username，免密码同步
		--  172.29.88.223::module ：同步到远程服务器目录，用于rsync模式
		target = sourceInfo['target'],
		-- init: 这是一个优化选项，当init = false，只同步进程启动以后发生改动事件的文件，原有的目录即使有差异也不会同步。默认是true
		init = true,
		-- delay 累计事件，等待rsync同步延时时间，默认15秒（最大累计到1000个不可合并的事件）。也就是15s内监控目录下发生的改动，会累积到一次rsync同步，避免过于频繁的同步。（可合并的意思是，15s内两次修改了同一文件，最后只同步最新的文件）
		delay = 15,
		-- excludeFrom: 排除选项，后面指定排除的列表文件，如excludeFrom = "/etc/lsyncd.exclude"，
		--  如果是简单的排除，可以使用exclude = LIST。
		--  这里的排除规则写法与原生rsync有点不同，更为简单：
		--      监控路径里的任何部分匹配到一个文本，都会被排除，例如/bin/foo/bar可以匹配规则foo
		--      如果规则以斜线/开头，则从头开始要匹配全部
		--      如果规则以/结尾，则要匹配监控路径的末尾
		--      ?匹配任何字符，但不包括/
		--      *匹配0或多个字符，但不包括/
		--      **匹配0或多个字符，可以是/
		-- delete: 为了保持target与souce完全同步，Lsyncd默认会delete = true来允许同步删除。它除了false，还有startup、running值
		delete = false,
		rsync = {
			binary = "/usr/bin/rsync",
			password_file = passwordFile,
			archive = true,
			compress = true,
			verbose = true,
			_extra = {"-e 'ssh -o stricthostkeychecking=no'", "--remove-source-files"},
		}
	}
end
