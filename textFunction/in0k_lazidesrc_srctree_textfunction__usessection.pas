unit in0k_lazIdeSRC_srcTree_textFunction__usesSection;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


//function srcTree_txtFnk__unitName_hasInToken(const unitName:string; out unitSingl,unitPath:string):boolean; overload; {$ifOpt D-}inline;{$endIf}
function srcTree_txtFnk__unitName_hazInToken(const unitName:string; out unitSingl:string)         :boolean; overload; {$ifOpt D-}inline;{$endIf}
function srcTree_txtFnk__unitName_hazInToken(const unitName:string)                               :boolean; overload; {$ifOpt D-}inline;{$endIf}


implementation


// UsedUnits.ToBeRenamedOrRemoved
// An 'in' unit => Delphi project file

function _hasInToken_(const token:string; const unitName:string; out unitSingl:string):boolean;
var i:integer;
begin
    i:=pos(token,unitName);
    if i>1 then begin
         unitSingl:=Copy(unitName, 1, i-1);
         result:=true
    end
    else result:=false;
end;


//------------------------------------------------------------------------------

const
  cInTOKEN00=' in ';
  cInTOKEN01=' In ';
  cInTOKEN02=' iN ';
  cInTOKEN03=' IN ';

//------------------------------------------------------------------------------

function srcTree_txtFnk__unitName_hazInToken(const unitName:string; out unitSingl:string):boolean;
begin
    result:=_hasInToken_(cInTOKEN00,unitName,unitSingl);
    if result then exit;
    result:=_hasInToken_(cInTOKEN01,unitName,unitSingl);
    if result then exit;
    result:=_hasInToken_(cInTOKEN02,unitName,unitSingl);
    if result then exit;
    result:=_hasInToken_(cInTOKEN03,unitName,unitSingl);
end;

function srcTree_txtFnk__unitName_hazInToken(const unitName:string):boolean;
begin
    result:=(pos(cInTOKEN00,unitName)>1) or
            (pos(cInTOKEN01,unitName)>1) or
            (pos(cInTOKEN02,unitName)>1) or
            (pos(cInTOKEN03,unitName)>1)  ;
end;

end.

