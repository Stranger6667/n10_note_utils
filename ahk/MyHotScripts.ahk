﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; SetCapsLockState, AlwaysOff

quote(string) {
    return """" string """"
}

get_my_utils_path(filename) {
	PYTHON_UTILS_DIR := "D:\Data\python\projects\note_utils\"
	
	fullpath :=  PYTHON_UTILS_DIR . filename
	fullpath := quote(fullpath)
    return fullpath
}

; window management
;#Up::WinMove A, ,0,0,A_ScreenWidth,(A_ScreenHeight-64)/2
;#Down::WinMove A, ,0,(A_ScreenHeight-64)/2,A_ScreenWidth,(A_ScreenHeight-64)/2


;CapsLock & 7:: send ⑦
;CapsLock & 8:: send ⑧
;CapsLock & 9:: send ⑨
;CapsLock & 0:: send ⑩

; 屏蔽微软五笔的全角半角切换
+Space::Send, {Space}

; supermemo, 将element转为纯文本
CapsLock & t::send ^+{F12}

; Abbyy ScreenshotReader
#Include %A_Scriptdir%\TrayIcon.ahk
AbbyyScreenReaderOCRText()
{
    TrayIcon_Button("ScreenshotReader.exe", "L")
    sleep, 100
    SendInput, r
	SetCapsLockState, Off
}

CapsLock & r::AbbyyScreenReaderOCRText()

CopyPlainText()
{
	clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
	send, ^c
	ClipWait, 2, 1 ; wait until clipboard contains data
    clipboard :=  clipboard  ; Convert any copied files, HTML, or other formatted text to plain text.
	SetCapsLockState, Off
}

Capslock & c::CopyPlainText()

CopyAsMarkdownHeader(marker)
{
	clipboard := marker
	sleep, 100
	Send, ^c
	SetCapsLockState, Off
}

CapsLock & 1:: CopyAsMarkdownHeader("#")
CapsLock & 2:: CopyAsMarkdownHeader("##")
CapsLock & 3:: CopyAsMarkdownHeader("###")
CapsLock & 4:: CopyAsMarkdownHeader("####")
CapsLock & 5:: CopyAsMarkdownHeader("#####")
CapsLock & 6:: CopyAsMarkdownHeader("######")

; 进入spotlight模式，方便进行阅读pacer
; Capslock & s::send ^!+P

LookUpDictionary()
{
   Clipboard := "" ; clear clipboard
   Send, ^c ; simulate Ctrl+C (=selection in clipboard)
   ClipWait, 2, 1 ; wait until clipboard contains data
   sleep, 200
   Send, ^!+c
   SetCapsLockState, Off
}

Capslock & d:: LookUpDictionary()

; 将剪贴板中的markdown文本转为html，再将html文本放回剪贴板
ClipboardMarkdownToHtml()
{
	fullexec_path := get_my_utils_path("src\markdown2clipboard.pyw")
	RunWait, pythonw %fullexec_path%
	ClipWait, 2, 1 ; wait until clipboard contains data
	SetCapsLockState, Off
}

Capslock & m:: ClipboardMarkdownToHtml()

N10NotesProcess()
{
	FileSelectFile, SelectedFiles, M3  ; M3 = Multiselect existing files.
	;MsgBox, The user selected the following:`n%SelectedFiles%
	if (SelectedFiles = "")
	{
		SetCapsLockState, Off
    	return
	}
	else
	{
		files := quote(SelectedFiles)	
		;MsgBox, The quoted string:`n%files%
		
		fullexec_path := get_my_utils_path("src\n10_note_for_ahk.pyw")
		RunWait, pythonw %fullexec_path% %files%
	}
	SetCapsLockState, Off
}

CapsLock & p:: N10NotesProcess()

SendMarkdownToOnenote()
{
	FileSelectFile, SelectedFile, 3, , , Markdown Documents (*.md)
	if (SelectedFile = "")
	{
		SetCapsLockState, Off
		return
	}
	else
	{
		 ;MsgBox, The user selected the following:`n%SelectedFile%
		 
		 quoted_selectedfile := quote(SelectedFile)
		 
		fullexec_path := get_my_utils_path("src\send_markdown_to_onenote_for_ahk.pyw")
		RunWait, pythonw %fullexec_path% %quoted_selectedfile%
		
		SplitPath, SelectedFile,, dir
		dirname := quote(dir)
		RunWait, python -m http.server -d %dirname%  9999
	}
	SetCapsLockState, Off
}

CapsLock &  o:: SendMarkdownToOnenote()

ListMarkdownLatexEquations()
{
	FileSelectFile, SelectedFile, 3, , , Markdown Documents (*.md)
	if (SelectedFile = "")
	{
		SetCapsLockState, Off
		return
	}
	else
	{
		 ;MsgBox, The user selected the following:`n%SelectedFile%
		 
		 quoted_selectedfile := quote(SelectedFile)
		 
		fullexec_path := get_my_utils_path("src\list_latex_equations.pyw")
		RunWait, pythonw %fullexec_path% %quoted_selectedfile%
		
		SplitPath, SelectedFile,, dir
		MsgBox, latex equations saved to %dir%\latex_equations.txt
	}
	SetCapsLockState, Off
}

CapsLock &  l:: ListMarkdownLatexEquations()

SendMarkdownToSupermemo()
{
	FileSelectFile, SelectedFile, 3, , , Markdown Documents (*.md)
	if (SelectedFile = "")
	{
		SetCapsLockState, Off
		return
	}
	else
	{
		 ;MsgBox, The user selected the following:`n%SelectedFile%
		 
		 quoted_selectedfile := quote(SelectedFile)
		 
		fullexec_path := get_my_utils_path("src\send_markdown_to_supermemo_from_ahk.py")
		RunWait, python %fullexec_path% %quoted_selectedfile%
		
		;SplitPath, SelectedFile,, dir
		;dirname := quote(dir)
		;RunWait, python -m http.server -d %dirname% 9999
	}
	SetCapsLockState, Off
}

CapsLock &  u:: SendMarkdownToSupermemo()

SendMarkdownToTheBrain()
{
	FileSelectFile, SelectedFile, 3, , , Markdown Documents (*.md)
	if (SelectedFile = "")
	{
		SetCapsLockState, Off
		return
	}
	else
	{
		 ;MsgBox, The user selected the following:`n%SelectedFile%
		 
		 quoted_selectedfile := quote(SelectedFile)
		 
		fullexec_path := get_my_utils_path("src\send_markdown_to_thebrain_from_ahk.pyw")
		RunWait, pythonw %fullexec_path% %quoted_selectedfile%
		
		SplitPath, SelectedFile,, dir
		dirname := quote(dir)
		RunWait, python -m http.server -d %dirname%  9999
	}
	SetCapsLockState, Off
}

CapsLock &  i:: SendMarkdownToTheBrain()	

NormalizedPaste()
{
	fullexec_path := get_my_utils_path("src\normalize_clipboard.pyw")
	RunWait, pythonw %fullexec_path%
	send, ^v
	SetCapsLockState, Off
}

CapsLock &  v:: NormalizedPaste()	

NormalizedPasteTheBrain()
{
	fullexec_path := get_my_utils_path("src\normalize_clipboard_thebrain.pyw")
	RunWait, pythonw %fullexec_path%
	send, ^v
	SetCapsLockState, Off
}

CapsLock &  b:: NormalizedPasteTheBrain()

RunSupermemo()
{
	process, exist, sm18.exe
	if !errorlevel
	    Run, "C:\SuperMemo\sm18.exe"
	
	Run, python -m http.server -d "D:\Data\supermemo\collections\webroot"  9999
	SetCapsLockState, Off
}

CapsLock &  s:: RunSupermemo()

StartNoteMonitor()
{
	fullexec_path := get_my_utils_path("src\notes_monitor.py")
	Run, python %fullexec_path%
	SetCapsLockState, Off
}

CapsLock &  n:: StartNoteMonitor()

GenerateSupermemoQA()
{
	FileSelectFile, SelectedFile, 3, , , Markdown Documents (*.md)
	if (SelectedFile = "")
	{
		SetCapsLockState, Off
		return
	}
	else
	{
		 ;MsgBox, The user selected the following:`n%SelectedFile%

		 quoted_selectedfile := quote(SelectedFile)

		fullexec_path := get_my_utils_path("src\supermemo_qa_generator.py")
		RunWait, pythonw %fullexec_path% %quoted_selectedfile%
	}
	SetCapsLockState, Off
}
CapsLock &  q:: GenerateSupermemoQA()


