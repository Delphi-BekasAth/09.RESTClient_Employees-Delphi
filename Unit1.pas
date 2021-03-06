unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, clsEmployee, System.Generics.Collections,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdAuthentication;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    employeeIdTxt: TEdit;
    showBtn: TButton;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    getDataBtn: TButton;
    printDataBtn: TButton;
    allEmployeesListBox: TListBox;
    aEmployeeListBox: TListBox;
    RESTClient2: TRESTClient;
    RESTRequest2: TRESTRequest;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    createNameTxt: TEdit;
    createSalaryTxt: TEdit;
    createAgeTxt: TEdit;
    createEmployeeBtn: TButton;
    RESTClient3: TRESTClient;
    RESTRequest3: TRESTRequest;
    RESTResponse2: TRESTResponse;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    deleteEmpTxt: TEdit;
    deleteEmpBtn: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    updateIdTxt: TEdit;
    updateNameTxt: TEdit;
    updateSalaryTxt: TEdit;
    updateAgeTxt: TEdit;
    findBtn: TButton;
    updateBtn: TButton;
    updateClearBtn: TButton;
    RESTClient4: TRESTClient;
    RESTRequest4: TRESTRequest;
    RESTResponse4: TRESTResponse;
    procedure getDataBtnClick(Sender: TObject);
    procedure printDataBtnClick(Sender: TObject);
    procedure showBtnClick(Sender: TObject);
    procedure createEmployeeBtnClick(Sender: TObject);
    procedure deleteEmpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure findBtnClick(Sender: TObject);
    procedure updateClearBtnClick(Sender: TObject);
    procedure updateBtnClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetAllEmployeesData;
    procedure Clearupdate;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var
  employees: TList<TEmployee>;

(*------------------------------------------------------------------------------*)

procedure TForm1.FormCreate(Sender: TObject);
begin

  employees := TList<TEmployee>.Create;

end;

(*------------------------------------------------------------------------------*)

procedure TForm1.FormDestroy(Sender: TObject);
begin

  FreeAndnil(employees);

end;

(*------------------------------------------------------------------------------*)

procedure TForm1.getDataBtnClick(Sender: TObject);
begin
  GetAllEmployeesData;
end;

(*------------------------------------------------------------------------------*)

// Print Employees to List
procedure TForm1.printDataBtnClick(Sender: TObject);
var
  emp: TEmployee;
  str: string;
begin

  allEmployeesListBox.Clear;
  for emp in employees do
  begin
    str := emp.GetId.ToString + ' ' + emp.GetName + ' ' + emp.GetSalary.ToString + ' ' + emp.GetAge.ToString;
    allEmployeesListBox.Items.Add(str);
  end;

  while employees.Count > 0  do
  begin
    FreeAndNil(employees[0]);
    employees.Delete(0);
  end;

end;

(*------------------------------------------------------------------------------*)

// JSON GET - Get one employee
procedure TForm1.showBtnClick(Sender: TObject);
var
  getId: string;
  jsv: TJSONValue;
  jsStatus: TJSonValue;
  jsMessage: TJSONValue;
  jsit: TJSONValue;
  id: Integer;
  name: string;
  salary: Double;
  age: Integer;

begin

    aEmployeeListBox.Clear;
    getId := employeeIdTxt.Text;

    try

    // Prepare Request's url
    RESTRequest2.ResourceSuffix := getId;

    // Execute request
    RESTRequest2.Execute;


      if RESTResponse1.StatusCode = 200 then
      begin

        // Extract JSON response
        jsv := TJSONObject.ParseJSONValue(RESTResponse1.Content);
        jsStatus := jsv.FindValue('status');
        jsMessage := jsv.FindValue('message');

        if jsStatus.Value = 'success' then
        begin

          ShowMessage(jsMessage.ToString);

          jsit := jsv.FindValue('data');

          id := jsit.GetValue<Integer>('id');
          name := jsit.GetValue<string>('name');
          salary := jsit.GetValue<Double>('salary');
          age := jsit.GetValue<Integer>('age');

          aEmployeeListBox.Items.Add('ID: ' + id.ToString);
          aEmployeeListBox.Items.Add('Name: ' + name);
          aEmployeeListBox.Items.Add('Salary: ' + salary.ToString);
          aEmployeeListBox.Items.Add('Age: ' + age.ToString);

        end
        else
        begin

          ShowMessage(jsMessage.Value);

        end;
      end;

    except
      on e: Exception do
        ShowMessage('Error. Connection faild');
    end;

end;

(*------------------------------------------------------------------------------*)

// JSON POST - Create an Employee
procedure TForm1.createEmployeeBtnClick(Sender: TObject);
var
  id: String;
  name: string;
  salary: string;
  age: string;
  jsres: TJSONValue;
  jsit: TJSONValue;
  jsData: TJSONValue;
  sucStr: String;

begin

  name := createNameTxt.Text;
  salary := createSalaryTxt.Text;
  age := createAgeTxt.Text;

  try

    // Configure POST parametempers
    RESTClient3.BaseURL := 'http://localhost:8080/create';

    RESTRequest3.Params.AddItem;
    RESTRequest3.Params.Items[0].name := 'name';
    RESTRequest3.Params.Items[0].Value := name;

    RESTRequest3.Params.AddItem;
    RESTRequest3.Params.Items[1].name := 'salary';
    RESTRequest3.Params.Items[1].Value := salary;

    RESTRequest3.Params.AddItem;
    RESTRequest3.Params.Items[2].name := 'age';
    RESTRequest3.Params.Items[2].Value := age;

    try

      // Execute request
      RESTRequest3.Execute;

      if RESTResponse2.StatusCode = 200 then
      begin

        // Extract JSON response
        jsres :=  TJSONObject.ParseJSONValue(RESTResponse2.Content);
        jsit := jsres.FindValue('status');
        jsData := jsres.FindValue('data');

        if jsit <> nil then
        begin

          id := jsData.GetValue<String>('id');
          name := jsData.GetValue<String>('name');
          salary := jsData.GetValue<String>('salary');
          age := jsData.GetValue<String>('age');

          sucStr := 'Success! ' + id + ', ' + name + ', ' + salary + ', ' + age + ' has been created';
          ShowMessage(sucStr);
        end
        else
          ShowMessage('Something went wrong. Try again!');

      end;

    except
      on e: Exception do
      ShowMessage(e.Message);

    end;

  except
    on e: Exception do
      ShowMessage(e.Message);

  end;

  createNameTxt.Clear;
  createSalaryTxt.Clear;
  createAgeTxt.Clear;

end;

(*------------------------------------------------------------------------------*)

// Delete an Employee
procedure TForm1.deleteEmpBtnClick(Sender: TObject);
var
  empId: string;
  jsv: TJSONValue;
  jsStatus: TJSONValue;
  jsMessage: TJSONValue;

begin

  empId := deleteEmpTxt.Text;

  try

    RESTClient3.BaseURL := 'http://localhost:8080/delete';
    RESTRequest3.ResourceSuffix := empId;

    // Execute request
    RESTRequest3.Execute;


      if RESTResponse2.StatusCode = 200 then
      begin

        // Extract JSON response
        jsv := TJSONObject.ParseJSONValue(RESTResponse2.Content);
        jsStatus := jsv.FindValue('status');
        jsMessage := jsv.FindValue('message');

        if jsStatus.Value = 'success' then
        begin

          ShowMessage(jsMessage.ToString);

        end
        else
        begin

          ShowMessage(jsMessage.Value);

        end;
      end;

  except

    on e: Exception do
        ShowMessage('Error. Connection faild');

  end;

  RESTRequest3.ResourceSuffix := '';

  deleteEmpTxt.Clear;

end;

(*------------------------------------------------------------------------------*)

//JSON GET - Get all Employees
procedure TForm1.GetAllEmployeesData;
var
  jsVl: TJSONValue;
  jsStatus: TJSONValue;
  jsMessage: TJSONValue;
  jsAr: TJSONArray;
  jsIt: TJSONValue;
  emp: TEmployee;
  empId: Integer;
  empName: string;
  empSalary: Double;
  empAge: Integer;

begin

  try

    // Execute request
    RESTRequest1.Execute;

    if RESTResponse1.StatusCode = 200 then
    begin

      // Extract JSON response
      jsVl := TJSONObject.ParseJSONValue(RESTResponse1.Content);


      jsStatus := jsVl.FindValue('status');
      jsMessage := jsVl.FindValue('message');

      if jsStatus.Value = 'success' then
      begin

        ShowMessage(jsMessage.Value);

        jsAr := jsVl.FindValue('data') as TJSONArray;

        for jsIt in jsAr do
        begin
          empId := jsIt.GetValue<Integer>('id');
          empName := jsIt.GetValue<string>('name');
          empSalary := jsIt.GetValue<Double>('salary');
          empAge := jsIt.GetValue<Integer>('age');

          emp := TEmployee.Create(empId, empName, empSalary, empAge);
          employees.Add(emp);
        end;


        printDataBtn.Enabled := true;

      end
      else
      begin
        ShowMessage(jsMessage.Value);
      end;

    end;

  except

    on Exception do
    begin
      ShowMessage('Error. Connection faild!');
    end;

  end;
end;

(*------------------------------------------------------------------------------*)

// Check employee ID for update
procedure TForm1.findBtnClick(Sender: TObject);
var
  idToCheck: Integer;
  jsResp: TJSONValue;
  jsStatus: TJSONValue;
  jsMes: TJSONValue;
  jsData: TJSONValue;

begin

  idToCheck := StrToInt(updateIdTxt.Text);

  try

    RESTClient4.BaseURL := 'http://localhost:8080/checkForUpdate';
    RESTRequest4.ResourceSuffix := idToCheck.ToString;
    RESTRequest4.Execute;

    if RESTResponse4.StatusCode = 200 then
    begin

      jsResp := TJSONObject.ParseJSONValue(RESTResponse4.Content);

      jsStatus := jsResp.FindValue('status');
      jsMes := jsResp.FindValue('message');

      if jsStatus.Value = 'success' then
      begin

        ShowMessage(jsMes.ToString);

        jsData := jsResp.FindValue('data');

        updateIdTxt.Enabled := false;
        findBtn.Enabled := false;

        updateNameTxt.Enabled := true;
        updateNameTxt.Text := jsData.GetValue<String>('name');

        updateSalaryTxt.Enabled := true;
        updateSalaryTxt.Text := jsData.GetValue<String>('salary');

        updateAgeTxt.Enabled := true;
        updateAgeTxt.Text := jsData.GetValue<String>('age');

        updateBtn.Enabled := true;

      end
      else if jsStatus.Value = 'not found' then
      begin

        ShowMessage(jsMes.ToString);
      end;


    end;


  except

    on e: Exception do
      ShowMessage('Error. Connection faild');

  end;

end;

(*------------------------------------------------------------------------------*)

procedure TForm1.updateBtnClick(Sender: TObject);
var
  id: Integer;
  name: string;
  salary: Double;
  age: Integer;
  jsResp: TJSONValue;
  jsStatus: TJSONValue;
  jsMes: TJSONValue;
  jsData: TJSONValue;

begin

  id := StrToInt(updateIdTxt.Text);
  name := updateNameTxt.Text;
  salary := StrToFloat(updateSalaryTxt.Text);
  age := StrToInt(updateAgeTxt.Text);

  try

    RESTClient4.BaseURL := 'http://localhost:8080/update';
    RESTRequest4.ResourceSuffix := id.ToString;

    RESTRequest4.Params.AddItem;
    RESTRequest4.Params.Items[0].name := 'name';
    RESTRequest4.Params.Items[0].Value := name;

    RESTRequest4.Params.AddItem;
    RESTRequest4.Params.Items[1].name := 'salary';
    RESTRequest4.Params.Items[1].Value := salary.ToString;

    RESTRequest4.Params.AddItem;
    RESTRequest4.Params.Items[2].name := 'age';
    RESTRequest4.Params.Items[2].Value := age.ToString;

    RESTRequest4.Execute;

    if RESTResponse4.StatusCode = 200 then
    begin

      jsResp := TJSONObject.ParseJSONValue(RESTResponse4.Content);

      jsStatus := jsResp.FindValue('status');
      jsMes := jsResp.FindValue('message');

      if jsStatus.Value = 'success' then
      begin

        ShowMessage(jsMes.ToString);
        ClearUpdate;

      end
      else if jsStatus.Value = 'not found' then
      begin

        ShowMessage(jsMes.ToString);
      end;


    end;


  except

    on e: Exception do
      ShowMessage('Error. Connection faild');

  end;


end;

(*------------------------------------------------------------------------------*)

procedure TForm1.updateClearBtnClick(Sender: TObject);
begin

  ClearUpdate;

end;

procedure TForm1.Clearupdate;
begin

    updateIdTxt.Clear;
  updateIdTxt.Enabled := true;
  findBtn.Enabled := true;

  updateNameTxt.Clear;
  updateNameTxt.Enabled := false;

  updateSalaryTxt.Clear;
  updateSalaryTxt.Enabled := false;

  updateAgeTxt.Clear;
  updateAgeTxt.Enabled := false;

  updateBtn.Enabled := false;

end;

end.
