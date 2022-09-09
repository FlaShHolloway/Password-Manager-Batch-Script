Const ForReading = 1
Const ForWriting = 2

strName = Wscript.Arguments(0)
strOriginal = Wscript.Arguments(1)
strReplacement = Wscript.Arguments(2)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strName, ForReading)

strText = objFile.ReadAll
objFile.Close

' Replace desired string
Set objRegExp = New RegExp
objRegExp.Global = True
objRegExp.IgnoreCase = True
objRegExp.Multiline = True
objRegExp.Pattern = strOriginal + "\s+[a-zA-Z]+\s+[a-zA-Z]+\s+"".*""\s+[a-zA-Z]+\s+\|(\s([a-zA-Z]+\s)+)/p="".*""+\s+\|(\s+([a-zA-Z]+\s+)+)[0-9]+\s+([a-zA-Z]+(\s+[a-zA-Z]+)+)\s+"".*""\s+[a-zA-Z]+\s+\|(\s+([a-zA-Z]+\s+)+)/p="".*""\s+\|(\s+([a-zA-Z]+\s+)+)"
strReplacement = objRegExp.Replace(strText, strReplacement)

Set objFile = objFSO.OpenTextFile(strName, ForWriting)
objFile.Write strReplacement
objFile.Close