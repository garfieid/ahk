; 双击右键，最大化 或 还原当前窗口
RButton::
if clickCount > 0 ; SetTimer 已经启动, 所以我们记录键击.
{
    clickCount += 1
    return
}
else
{
	; 记录当前鼠标位置
	MouseGetPos, xPos1,yPos1,wid
	; 否则, 这是新开始系列中的首次按下. 把次数设为 1 并启动计时器：
	clickCount = 1
	SetTimer, RightButton, 200 ; 在 200 毫秒内等待更多的键击.
	
	
	return
}
RightButton:
{
	SetTimer, RightButton, off
	if clickCount = 1 ; 此键按下了一次.
	{
		MouseGetPos, xPos2,yPos2
		xMove := xPos1-xPos2
		SysGet, area, MonitorWorkArea
		leftWidth := areaRight*2/5
		if(xMove < -100)
		{
			; 向右移动
			WinActivate, ahk_id %wid%
			WinRestore,ahk_id %wid%
			WinMove, ahk_id %wid%,,leftWidth,0,(areaRight - leftWidth),areaBottom
		}
		else if(xMove > 100)
		{			
			; 向左移动
			WinActivate, ahk_id %wid%
			WinRestore,ahk_id %wid%
			WinMove, ahk_id %wid%,,1,1,leftWidth,areaBottom
		}	
		else
		{
			send {RButton}
		}
	}
	else if clickCount >= 2 ; 此键按下了两次或以上.
	{
		WinActivate, ahk_id %wid% 
		WinGetActiveStats, Title, Width, Height, X, Y
		if(X > 0 || Y > 0)
		{
			WinMaximize,ahk_id %wid%
		}
		else
		{
			WinRestore,ahk_id %wid%
		}
	}
	; 不论触发了上面的哪个动作, 都对 count 进行重置
	; 为下一个系列的按下做准备:
	clickCount = 0
	return
}
; 双击右键，最大化 或 还原当前窗口 END
