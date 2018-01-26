unit in0k_lazIdeSRC_srcTree_CORE_Processing;

{$mode objfpc}{$H+}

interface

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}
        in0k_lazIdeSRC_DEBUG,
     {$endIf}
     sysutils;

type

 mSrcTree_Processing_LOG=procedure(const message:string) of object;

 tSrcTree_Processing=class
  private
   _datiM_:tDateTime;
   _doLog_:mSrcTree_Processing_LOG;
  protected
    procedure writeLOG(const message:string); inline;
    procedure writeLOG_BEGIN;                 inline;
    procedure writeLOG_isEND;                 inline;
  public
    property  M4LOG:mSrcTree_Processing_LOG read _doLog_  write _doLog_;
    constructor Create;
  end;

implementation

{%region --- возня с ДЕБАГОМ -------------------------------------- /fold}
{$if defined(in0k_lazExt_CopyRAST_wndCORE___DebugLOG) AND declared(in0k_lazIde_DEBUG)}
    // `in0k_lazIde_DEBUG` - это функция ИНДИКАТОР что используется
    //                       моя "система имен и папок"
    {$define _debug_}    //< типа да ... можно делать ДЕБАГ отметки
{$else}
    {$undef _debug_}
{$endIf}
{%endregion}

constructor tSrcTree_Processing.Create;
begin
   _doLog_:=nil;
   _datiM_:=0;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_Processing.writeLOG(const message:string);
begin
    if Assigned(_doLog_) then _doLog_('['+self.ClassName+']'+' '+message);
    {$ifDef _DEBUG_}DEBUG('['+self.ClassName+']'+' '+message);{$endIf}
end;

procedure tSrcTree_Processing.writeLOG_BEGIN;
begin
   _datiM_:=NOW;
    writeLOG('<---> BEGIN ('+DateTimeToStr(_datiM_)+').');
end;

procedure tSrcTree_Processing.writeLOG_isEND;
begin
   _datiM_:=NOW-_datiM_;
    writeLOG('<---> isEND ('+DateTimeToStr(NOW)+'). Processing in '+ inttostr(round(_datiM_/SecsPerDay))+' sec.');
end;

end.

