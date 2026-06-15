sub init()
	m.top.functionName = "getContent"
end sub

sub getContent()
	feedurl = m.global.feedurl

	m.port = CreateObject("roMessagePort")
	searchRequest = CreateObject("roUrlTransfer")
	searchRequest.setURL(feedurl)
	searchRequest.SetPort(m.port)
	searchRequest.EnableEncodings(true)
	httpsReg = CreateObject("roRegex", "^https:", "")
	if httpsReg.isMatch(feedurl)
		searchRequest.SetCertificatesFile("common:/certs/ca-bundle.crt")
		searchRequest.AddHeader("X-Roku-Reserved-Dev-Id", "")
		searchRequest.InitClientCertificates()
	end if

	if searchRequest.AsyncGetToString()
		event = wait(60000, m.port)
		if type(event) = "roUrlEvent"
			responseCode = event.GetResponseCode()
			if responseCode = 200
				text = event.GetString()
				if text = "" or text = invalid then
					print ">>> PLAYLIST ERROR: Response was empty or invalid"
					print ">>> PLAYLIST ERROR: URL = "; feedurl
					m.top.content = CreateObject("roSGNode", "ContentNode")
					return
				end if
			else
				print ">>> PLAYLIST ERROR: HTTP error code "; responseCode; " for URL: "; feedurl
				if responseCode = 401 then print ">>> PLAYLIST ERROR: Unauthorized — check credentials"
				if responseCode = 403 then print ">>> PLAYLIST ERROR: Forbidden — access denied"
				if responseCode = 404 then print ">>> PLAYLIST ERROR: Not found — check the playlist URL"
				if responseCode = 500 then print ">>> PLAYLIST ERROR: Server error — the playlist server is having problems"
				if responseCode = 0   then print ">>> PLAYLIST ERROR: No response — possible network or DNS issue"
				m.top.content = CreateObject("roSGNode", "ContentNode")
				return
			end if
		else
			print ">>> PLAYLIST ERROR: Request timed out after 60 seconds for URL: "; feedurl
			m.top.content = CreateObject("roSGNode", "ContentNode")
			return
		end if
	else
		print ">>> PLAYLIST ERROR: Failed to start HTTP request for URL: "; feedurl
		m.top.content = CreateObject("roSGNode", "ContentNode")
		return
	end if

	reHasGroups = CreateObject("roRegex", "group-title\=" + chr(34) + "?([^" + chr(34) + "]*)"+chr(34)+"?,","")
	hasGroups = reHasGroups.isMatch(text)
	print ">>> PLAYLIST: Has groups = "; hasGroups

	reLineSplit = CreateObject("roRegex", "(?>\r\n|[\r\n])", "")
	reExtinf = CreateObject("roRegex", "(?i)^#EXTINF:\s*(\d+|-1|-0).*,\s*(.*)$", "")
	reSemicolon = CreateObject("roRegex", ";", "")
	rePath = CreateObject("roRegex", "^([^#].*)$", "")
	inExtinf = false
	con = CreateObject("roSGNode", "ContentNode")
	groupNames = [] ' list of group names for the current channel

	channelCount = 0
	for each line in reLineSplit.Split(text)
		if inExtinf
			maPath = rePath.Match(line)
			if maPath.Count() = 2
				url = maPath[1]
				if hasGroups and groupNames.Count() > 0
					' Add channel to each group it belongs to
					for each gName in groupNames
						groupNode = invalid
						for x = 0 to con.getChildCount() - 1
							node = con.getChild(x)
							if node.id = gName
								groupNode = node
								exit for
							end if
						end for
						if groupNode = invalid
							groupNode = con.CreateChild("ContentNode")
							groupNode.contenttype = "SECTION"
							groupNode.title = gName
							groupNode.id = gName
						end if
						item = groupNode.CreateChild("ContentNode")
						item.url = url
						item.title = title
					end for
				else
					item = con.CreateChild("ContentNode")
					item.url = url
					item.title = title
				end if
				channelCount = channelCount + 1
				inExtinf = False
				groupNames = []
			end if
		end if
		maExtinf = reExtinf.Match(line)
		if maExtinf.Count() = 3
			groupNames = []
			if hasGroups
				maGroup = reHasGroups.Match(line)
				if maGroup.Count() >= 2 then
					rawGroup = maGroup[1]
					if rawGroup = "" or rawGroup = invalid then
						groupNames.Push("Other")
					else
						' Split on semicolons for multi-group support
						parts = reSemicolon.Split(rawGroup)
						for each part in parts
							trimmed = part.Trim()
							if trimmed <> "" then groupNames.Push(trimmed)
						end for
						if groupNames.Count() = 0 then groupNames.Push("Other")
					end if
				else
					groupNames.Push("Other")
				end if
			end if
			length = maExtinf[1].ToInt()
			if length < 0 then length = 0
			title = maExtinf[2]
			if title = "" or title = invalid then
				title = "Unknown Channel"
			end if
			inExtinf = True
		end if
	end for

	print ">>> PLAYLIST: Total channels loaded: "; channelCount
	if channelCount = 0 then
		print ">>> PLAYLIST WARNING: Playlist parsed successfully but contained no channels"
		print ">>> PLAYLIST WARNING: Check that the M3U format is correct for URL: "; feedurl
	end if

	m.top.content = con
end sub
