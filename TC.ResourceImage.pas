unit TC.ResourceImage;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects;

type
  TResourceImage = class(TImage)
  private
    { Déclarations privées }
    FResourceName: string;
    procedure SetResourceName(const Value: string);
  protected
    { Déclarations protégées }
    procedure InternalLoad;
  public
    { Déclarations publiques }
  published
    { Déclarations publiées }
    property ResourceName: string read FResourceName write SetResourceName;

    procedure Reload;
  end;

procedure Register;

implementation

uses
  System.Types
  ;

procedure Register;
begin
  RegisterComponents('TCComponents', [TResourceImage]);
end;

{ TResourceImage }

procedure TResourceImage.InternalLoad;
var
  oResourceStream: TResourceStream;
begin
  try
    oResourceStream := TResourceStream.Create(MainInstance, FResourceName, RT_RCDATA);
    Bitmap.LoadFromStream(oResourceStream);
  finally
    FreeAndNil(oResourceStream);
  end;
end;

procedure TResourceImage.Reload;
begin
  InternalLoad;
end;

procedure TResourceImage.SetResourceName(const Value: string);
begin
  FResourceName := Value;
  if (not (csDesigning in ComponentState)) then
    InternalLoad;
end;

end.
