Sub CombineOrganizer()

Application.ScreenUpdating = False


    Range("A1:A2").Select
    Selection.EntireRow.Delete
	Range("A1").Select
    Selection.EntireColumn.Insert
    Range("E1").Select
    Selection.EntireColumn.Delete
	Range("O1").Select
    Selection.EntireColumn.Delete
	
	
	
	Range("A2").Select
    ActiveCell.FormulaR1C1 = "=IF(ISNUMBER(RC[1]) = TRUE,1,"""")"
    Range("B2").Select
    Selection.End(xlDown).Select
    Range("A25000").Select
    ActiveCell.FormulaR1C1 = "z"
    Range("A25000").Select
    Selection.End(xlUp).Select
    Selection.Copy
    Range("A3").Select
    Range(Selection, Selection.End(xlDown)).Select
    ActiveSheet.Paste
    Range("A2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Range("A2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Application.CutCopyMode = False
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=True, Transpose:=False
		
	
	Range("A1:U25000").Select
    Selection.AutoFilter
    ActiveSheet.Range("$A$1:$U$25000").AutoFilter Field:=1, Criteria1:="<>"
    Selection.Copy
    Sheets.Add After:=ActiveSheet
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False

	
	
    Range("A1").Select
    Selection.EntireColumn.Delete
	
	Application.DisplayAlerts = False
	
	Sheets("combine").Select
    ActiveWindow.SelectedSheets.Delete
    Sheets("Sheet1").Select
    Sheets("Sheet1").Name = "combine"
	
	Range("U1").Select
    ActiveCell.FormulaR1C1 = "DateModified"
	
	Range("A2").Select
    Range(Selection, Selection.End(xlDown)).Select
    Selection.NumberFormat = "m/d/yyyy"
    
End Sub