object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 563
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 17
    Width = 66
    Height = 13
    Caption = 'Employee Id: '
  end
  object Label2: TLabel
    Left = 19
    Top = 216
    Width = 34
    Height = 13
    Caption = 'Name: '
  end
  object Label3: TLabel
    Left = 16
    Top = 243
    Width = 37
    Height = 13
    Caption = 'Salary: '
  end
  object Label4: TLabel
    Left = 27
    Top = 270
    Width = 26
    Height = 13
    Caption = 'Age: '
  end
  object Label5: TLabel
    Left = 19
    Top = 191
    Width = 55
    Height = 19
    Caption = 'Create'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 19
    Top = 380
    Width = 54
    Height = 19
    Caption = 'Delete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 22
    Top = 408
    Width = 18
    Height = 13
    Caption = 'ID: '
  end
  object Label8: TLabel
    Left = 367
    Top = 358
    Width = 59
    Height = 19
    Caption = 'Update'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 367
    Top = 391
    Width = 18
    Height = 13
    Caption = 'ID: '
  end
  object Label10: TLabel
    Left = 367
    Top = 421
    Width = 34
    Height = 13
    Caption = 'Name: '
  end
  object Label11: TLabel
    Left = 367
    Top = 448
    Width = 37
    Height = 13
    Caption = 'Salary: '
  end
  object Label12: TLabel
    Left = 367
    Top = 480
    Width = 26
    Height = 13
    Caption = 'Age: '
  end
  object employeeIdTxt: TEdit
    Left = 88
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 0
  end
  object showBtn: TButton
    Left = 143
    Top = 12
    Width = 89
    Height = 25
    Caption = 'Show Employee'
    TabOrder = 1
    OnClick = showBtnClick
  end
  object getDataBtn: TButton
    Left = 359
    Top = 16
    Width = 99
    Height = 25
    Caption = 'Get All Employees'
    TabOrder = 2
    OnClick = getDataBtnClick
  end
  object printDataBtn: TButton
    Left = 464
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Print Data'
    Enabled = False
    TabOrder = 3
    OnClick = printDataBtnClick
  end
  object allEmployeesListBox: TListBox
    Left = 367
    Top = 47
    Width = 258
    Height = 282
    ItemHeight = 13
    TabOrder = 4
  end
  object aEmployeeListBox: TListBox
    Left = 16
    Top = 43
    Width = 216
    Height = 110
    ItemHeight = 13
    TabOrder = 5
  end
  object createNameTxt: TEdit
    Left = 59
    Top = 216
    Width = 70
    Height = 21
    TabOrder = 6
  end
  object createSalaryTxt: TEdit
    Left = 59
    Top = 240
    Width = 70
    Height = 21
    TabOrder = 7
  end
  object createAgeTxt: TEdit
    Left = 59
    Top = 267
    Width = 70
    Height = 21
    TabOrder = 8
  end
  object createEmployeeBtn: TButton
    Left = 135
    Top = 265
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 9
    OnClick = createEmployeeBtnClick
  end
  object deleteEmpTxt: TEdit
    Left = 59
    Top = 405
    Width = 70
    Height = 21
    TabOrder = 10
  end
  object deleteEmpBtn: TButton
    Left = 135
    Top = 403
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 11
    OnClick = deleteEmpBtnClick
  end
  object updateIdTxt: TEdit
    Left = 418
    Top = 387
    Width = 121
    Height = 21
    TabOrder = 12
  end
  object updateNameTxt: TEdit
    Left = 418
    Top = 418
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 13
  end
  object updateSalaryTxt: TEdit
    Left = 418
    Top = 445
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 14
  end
  object updateAgeTxt: TEdit
    Left = 418
    Top = 477
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 15
  end
  object findBtn: TButton
    Left = 550
    Top = 385
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 16
    OnClick = findBtnClick
  end
  object updateBtn: TButton
    Left = 494
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Update'
    Enabled = False
    TabOrder = 17
    OnClick = updateBtnClick
  end
  object updateClearBtn: TButton
    Left = 575
    Top = 520
    Width = 91
    Height = 25
    Caption = 'Clear'
    TabOrder = 18
    OnClick = updateClearBtnClick
  end
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost:8080/employees'
    Params = <>
    Left = 368
    Top = 72
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 448
    Top = 72
  end
  object RESTResponse1: TRESTResponse
    Left = 520
    Top = 72
  end
  object RESTClient2: TRESTClient
    BaseURL = 'http://localhost:8080/employee'
    Params = <>
    Left = 40
    Top = 64
  end
  object RESTRequest2: TRESTRequest
    Client = RESTClient2
    Params = <>
    ResourceSuffix = '24'
    Response = RESTResponse1
    Left = 112
    Top = 64
  end
  object RESTClient3: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/create'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    Left = 24
    Top = 296
  end
  object RESTRequest3: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient3
    Method = rmPOST
    Params = <>
    Response = RESTResponse2
    Left = 96
    Top = 296
  end
  object RESTResponse2: TRESTResponse
    ContentType = 'application/json'
    Left = 176
    Top = 296
  end
  object RESTClient4: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    Left = 296
    Top = 512
  end
  object RESTRequest4: TRESTRequest
    Client = RESTClient4
    Method = rmPOST
    Params = <>
    Response = RESTResponse4
    Left = 360
    Top = 512
  end
  object RESTResponse4: TRESTResponse
    ContentType = 'application/json'
    Left = 416
    Top = 512
  end
end
