Sub Mover()
'
' Mover Macro
'

'
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("BasicOutput").Select
    Range("A1:AI2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("BasicOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("BankAccountsOutput").Select
    Range("A1:C11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("BankAccountsOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("DebtSummaryOutput").Select
    Range("A1:J2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("DebtSummaryOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("EmergenciesOutput").Select
    Range("A1:I2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("EmergenciesOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("ExpensesOutput").Select
    Range("A1:AE2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("ExpensesOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("HouseholdGoodsOutputs").Select
    Range("A1:C11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("HouseholdGoodsOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("HousePmtsOutput").Select
    Range("A1:L21").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("HousePmtsOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("IncomeOutputs").Select
    Range("A1:AP2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("IncomeOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("MarketingOutputs").Select
    Range("A1:F2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("MarketingOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("MiscOutput").Select
    Range("A1:E2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("MiscOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("PersonalPropertyOutputs").Select
    Range("A1:AE2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("PersonalPropertyOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("RealPropertyOutputs").Select
    Range("A1:M11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("RealPropertyOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("Rent2OwnOutputs").Select
    Range("A1:G11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("Rent2OwnOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("SecuredCreditorOutputs").Select
    Range("A1:J11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("SecuredCreditorOutputs").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("TaxesOutput").Select
    Range("A1:AC2").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("TaxesOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("VehicleLoansOutput").Select
    Range("A1:K11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("VehicleLoansOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    Windows("ConsultConverte1r.xlsx").Activate
    Sheets("VehiclesOutput").Select
    Range("A1:G11").Select
    Selection.Copy
    Windows("Target.xlsm").Activate
    Sheets("VehiclesOutput").Select
    Range("A1").Select
    ActiveSheet.Paste
    
    
    
    
End Sub

Sub Cleaner()
'
' Cleaner Macro
'

'
    Sheets("VehiclesOutput").Select
    Range("A1:H15").Select
    Selection.ClearContents
    
    Sheets("VehicleLoansOutput").Select
    Range("A1:K11").Select
    Selection.ClearContents
    
    Sheets("TaxesOutput").Select
    Range("A1:AC2").Select
    Selection.ClearContents
    
    Sheets("SecuredCreditorOutputs").Select
    Range("A1:J11").Select
    Selection.ClearContents
    
    Sheets("Rent2OwnOutputs").Select
    Range("A1:G11").Select
    Selection.ClearContents
    
    Sheets("RealPropertyOutputs").Select
    Range("A1:M11").Select
    Selection.ClearContents
    
    Sheets("PersonalPropertyOutputs").Select
    Range("A1:AE2").Select
    Selection.ClearContents
    
    Sheets("MiscOutput").Select
    Range("A1:E3").Select
    Selection.ClearContents
    
    Sheets("MarketingOutputs").Select
    Range("A1:F3").Select
    Selection.ClearContents
    
    Sheets("IncomeOutputs").Select
    Range("A1:AP3").Select
    Selection.ClearContents
    
    Sheets("HousePmtsOutput").Select
    Range("A1:L21").Select
    Selection.ClearContents
    
    Sheets("HouseholdGoodsOutputs").Select
    Range("A1:C11").Select
    Selection.ClearContents
    
    Sheets("ExpensesOutput").Select
    Range("A1:AE3").Select
    Selection.ClearContents
    
    Sheets("EmergenciesOutput").Select
    Range("A1:I3").Select
    Selection.ClearContents
    
    Sheets("DebtSummaryOutput").Select
    Range("A1:J3").Select
    Selection.ClearContents
    
    Sheets("BasicOutput").Select
    Range("A1:AI2").Select
    Selection.ClearContents
    
    Sheets("BankAccountsOutput").Select
    Range("A1:C11").Select
    Selection.ClearContents
    
    
End Sub
