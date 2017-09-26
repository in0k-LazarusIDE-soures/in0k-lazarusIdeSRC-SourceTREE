unit srcTree_handler_CORE;

{$mode objfpc}{$H+}

interface

{$define _DEBUG_}

{$i in0k_lazIdeSRC_SETTINGs.inc} //< настройки компанента-Расширения.
//< Можно смело убирать, так как будеть работать только в моей специальной
//< "системе имен и папок" `in0k_LazExt_..`.

uses {$ifDef in0k_lazExt_CopyRAST_wndCORE___DebugLOG}in0k_lazIdeSRC_DEBUG,{$endIf}
     srcTree_builder_CORE,
     in0k_lazIdeSRC_srcTree_CORE_item,
     in0k_lazIdeSRC_srcTree_CORE_Processing;

     //sysutils,
     //lazExt_CopyRAST_node,
     //lazExt_CopyRAST_node_ROOT,
     //lazExt_CopyRAST_Node2TEXTs;// lazExt_CopyRAST_node, lazExt_CopyRAST_node_ROOT;

type


  tCopyRast_counter=LongWord;
  tSrcTree_prcHandler=class;

  //tCopyRAST_node=class
  // end;
  tSrcTree_itmHandler=class;
  tSrcTree_itmHandler_TYPE=class of tSrcTree_itmHandler;

  {УЗЕЛ по ОБРАБОТКе}
 tSrcTree_itmHandler=class(tSrcTree_Processing)
  private // структурные моменты
   _OWNER_:tSrcTree_prcHandler; // САМЫЙ главный
   _PARNT_:tSrcTree_itmHandler; // родитель
    //function _get_toolHigher_:tSrcTree_itmHandler;
    //function _get_rootHigher_:tCopyRAST_ROOT;
  private // текущая работа
   _eITEM_:tSrcTree_item;       // ТЕКУЩИЙ узел для обработки
   _eDATA_:pointer;             // некие данные по обработке

  protected
    function  Root   :tSrcTree_item;
    function  Builder:tSrcTree_Builder_CORE;
  protected
    procedure doEvent_onNoNeed(const message:string);
    procedure doEvent_onPASSED(const message:string);
    procedure doEvent_on_ERROR(const message:string);
  protected
    function EXECUTE_4TREE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
    function EXECUTE_4NODE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer; eItem:tSrcTree_item):boolean;
    function EXECUTE_4NODE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
  public
    //property  Tool_Higher:tSrcTree_itmHandler read _get_toolHigher_;
    //property  Tool_Parent:tSrcTree_itmHandler read _PARNT_;
    //property  node4Execut:tSrcTree_item read _eITEM_;
    //function  Is_Possible:boolean; virtual;
    //function  doOperation:boolean; virtual;
  public // ВЫПОЛНЕНИЕ
    property  prcssdITEM:tSrcTree_item read _eITEM_;               // обрабатываемый узел
    property  prcssdDATA:pointer       read _eDATA_ write _eDATA_; // данные по обработке
    function  Processing:boolean;   virtual;                       // ВЫПОЛНИТЬ обработку
  public
    constructor Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler); virtual;
  end;

        //   processing

  tSrcTree_prcHandler=class(tSrcTree_Processing)
   private
    _all_tryEXE_:LongWord; //< кол-во Попыток запуска
    _cnt_ERRORs_:LongWord; //< кол-во Реально запущеных
    _cnt_actual_:LongWord; //< кол-во Реально запущеных
    _cnt_MISSED_:LongWord; //< кол-во ПРОПУЩЕНЫХ
    _cnt_PASSED_:LongWord; //< кол-во Выполненных
    _cnt_NoNeed_:LongWord; //< кол-во УЖЕ сделаных ранее
    _err_TEXT_:string;
     procedure _CNTs_CLN_;
   private
     function  _create_OprNode_(const nodeType:tSrcTree_itmHandler_TYPE; const Parent:tSrcTree_itmHandler):tSrcTree_itmHandler;
   private
    _time_:QWord;
   private
    _doLog_onMISSED_:boolean;
    _doLog_onNoNeed_:boolean;
   private
     //procedure _doEvent_onMISSED_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node);
     //procedure _doEvent_onNoNeed_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
     //procedure _doEvent_onPASSED_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
     //procedure _doEvent_on_ERROR_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
   private
    _nodeRoot_:tSrcTree_item;
    _builder_ :tSrcTree_Builder_CORE;
   private
     function  _EXECUTE_wasER_:boolean;
     function  _EXECUTE__NODE_(const Handler:tSrcTree_itmHandler; const eData:pointer; const eItem:tSrcTree_item):boolean;
     function  _EXECUTE_4NODE_(const eParent:tSrcTree_itmHandler; const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer; const eItem:tSrcTree_item):boolean;
     function  _EXECUTE__TREE_(const Handler:tSrcTree_itmHandler; const eData:pointer; const eItem:tSrcTree_item):boolean;
     function  _EXECUTE_4TREE_(const eParent:tSrcTree_itmHandler; const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
   protected
     procedure _EXECUTE_4ROOT_(const Handler:tSrcTree_itmHandler_TYPE);
   protected
     procedure _make_log_Start_;
     procedure _make_log_onEND_;
   protected
     procedure _EXECUTE_; virtual;
   public
     constructor Create;
     procedure  EXECUTE(const Builder:tSrcTree_Builder_CORE; const nodeRoot:tSrcTree_item);// virtual;//(const eItem:tOperationNode_TYPE):boolean;
   end;


//  machining
//  the
//  processing node
//  prcNode
//  prcMCHN
//
//  handler
//  prcEXEC

implementation

// @prm Owner  владелец обработчик
// @prm Parent выше стоящий УЗЕЛ обработки
constructor tSrcTree_itmHandler.Create(const Owner:tSrcTree_prcHandler; const Parent:tSrcTree_itmHandler);
begin
   _OWNER_:=Owner;
   _PARNT_:=Parent;
   _eITEM_:=NIL;
   _eDATA_:=NIL;
end;

function tSrcTree_itmHandler.Processing:boolean; // ВЫПОЛНИТЬ обработку
begin
    result:=true;
end;

//------------------------------------------------------------------------------

{function tSrcTree_itmHandler._get_toolHigher_:tSrcTree_itmHandler;
begin
    result:=self;
    while Assigned(result._PARNT_) do result:=result._PARNT_;
end;}

{function tSrcTree_itmHandler._get_rootHigher_:tCopyRAST_ROOT;
var tmp:tCopyRAST_node;
begin
    result:=nil;
    tmp:=_eITEM_;
    while (Assigned(tmp))and(not (tmp is tCopyRAST_ROOT)) do tmp:=tmp.NodePRNT;
end;}

//------------------------------------------------------------------------------

function tSrcTree_itmHandler.Builder:tSrcTree_Builder_CORE;
begin
    result:=tSrcTree_prcHandler(_OWNER_)._builder_;
end;

function tSrcTree_itmHandler.Root:tSrcTree_item;
begin
   result:=tSrcTree_prcHandler(_OWNER_)._nodeRoot_;
end;

//------------------------------------------------------------------------------

// вызвать при УСПЕШНОМ редактировании
procedure tSrcTree_itmHandler.doEvent_onPASSED(const message:string);
begin
  // _OWNER_._doEvent_onPASSED_(self,_eITEM_,message);
end;

// вызвать при УЖЕ сделано
procedure tSrcTree_itmHandler.doEvent_onNoNeed(const message:string);
begin
  // _OWNER_._doEvent_onNoNeed_(self,_eITEM_,message);
end;

// вызвать при ВОЗНИКНОВЕНИИ ошибки
procedure tSrcTree_itmHandler.doEvent_on_ERROR(const message:string);
begin
  // _OWNER_._doEvent_on_ERROR_(self,_eITEM_,message);
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// запустить выполнение для ОПРЕДЕЛЕННОГО узла
function tSrcTree_itmHandler.EXECUTE_4NODE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer; eItem:tSrcTree_item):boolean;
begin
    result:=_OWNER_._EXECUTE_4NODE_(self,tHandler,eData,eItem);
end;

// запустить выполнение для ТЕКУЩЕГО узла
function tSrcTree_itmHandler.EXECUTE_4NODE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
begin
    result:=EXECUTE_4NODE(tHandler,eData,_eITEM_);
end;

// запустить выполнение для ВСЕГО дерева
function tSrcTree_itmHandler.EXECUTE_4TREE(const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
begin
    result:=_OWNER_._EXECUTE_4TREE_(self,tHandler,eData);
end;

//------------------------------------------------------------------------------

// проверить, возможна ли (выполнима ли) операция для узла
{function tSrcTree_itmHandler.Is_Possible:boolean;
begin
    result:=FALSE;
    {$ifdef _DEBUG_}DEBUG(Self.ClassName+'.Is_Possible='+BoolToStr(result,' true','false')+' for '+CopyRastNode2TEXTs(node4Execut));{$endIf}
end;}

// выполнить операцию над текущим узлом
{function tSrcTree_itmHandler.doOperation:boolean;
begin
    result:=TRUE;
    {$ifdef _DEBUG_}DEBUG(Self.ClassName+'.doOperation='+BoolToStr(result,' true','false')+' for '+CopyRastNode2TEXTs(node4Execut));{$endIf}
end;}

//------------------------------------------------------------------------------
//==============================================================================

constructor tSrcTree_prcHandler.Create;
begin
   _doLog_onMISSED_:=false;
   _doLog_onNoNeed_:=false;
   _nodeRoot_:=nil;
   _CNTs_CLN_;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler._EXECUTE_;
begin

end;

procedure tSrcTree_prcHandler.EXECUTE(const Builder:tSrcTree_Builder_CORE; const nodeRoot:tSrcTree_item);
begin
   _nodeRoot_:=nodeRoot;
   _builder_ :=Builder;
    //----
    writeLOG_BEGIN;
    writeLOG('nodeRoot('+nodeRoot.ClassName+')');
    // _doLog_onMISSED_:=;
   _EXECUTE_;
    writeLOG_isEND;
end;

//------------------------------------------------------------------------------

function tSrcTree_prcHandler._create_OprNode_(const nodeType:tSrcTree_itmHandler_TYPE; const Parent:tSrcTree_itmHandler):tSrcTree_itmHandler;
begin
    result:=nodeType.Create(self,Parent);
    result.M4LOG:=Self.M4LOG;
    //---
    //result.
end;



//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler._CNTs_CLN_;
begin
   _cnt_ERRORs_:=0;
   _all_tryEXE_:=0;
   _cnt_actual_:=0;
   _cnt_MISSED_:=0;
   _cnt_PASSED_:=0;
   _cnt_NoNeed_:=0;
end;

//------------------------------------------------------------------------------

const
  _c_onEvent_TXT_passed_='Passed';
  _c_onEvent_TXT_noNeed_='noNeed';
  _c_onEvent_TXT_missed_='missed';
  _c_onEvent_TXT__Error_='ERROR!';

{procedure tSrcTree_Processing._doEvent_onMISSED_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node);
begin
    inc(_cnt_MISSED_);
    if _doLog_onMISSED_ then begin
        {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_missed_,' ['+Self.ClassName+'.Is_Possible='+BoolToStr(FALSE,' true','false')+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
        {todo: запись в txtЛог}
	end;
end;}

{procedure tSrcTree_Processing._doEvent_onNoNeed_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_NoNeed_);
    if _doLog_onNoNeed_ then begin
        {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_noNeed_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
        {todo: запись в txtЛог}
	end;
end;}

{procedure tSrcTree_Processing._doEvent_onPASSED_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_PASSED_);
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_passed_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
    {todo: запись в txtЛог}
    ApplicationName;
end;}

{procedure tSrcTree_Processing._doEvent_on_ERROR_(const Oprt:tSrcTree_itmHandler; const node:tCopyRAST_node; const MSG:string);
begin
    inc(_cnt_ERRORs_);
   _err_TEXT_:=MSG;
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT__Error_,MSG+' ['+Oprt.ClassName+' for '+CopyRastNode2TEXTs(node)+']');{$endIf}
    {todo: запись в txtЛог}
end;}

//------------------------------------------------------------------------------

function tSrcTree_prcHandler._EXECUTE_wasER_:boolean;
begin
    result:=_err_TEXT_<>'';
end;

//------------------------------------------------------------------------------

// выполняем операцию для ЕДИНСТВЕННОГО "узла информации"
// @ret false дальнейшее выполнение прекратить
function tSrcTree_prcHandler._EXECUTE__NODE_(const Handler:tSrcTree_itmHandler; const eData:pointer; const eItem:tSrcTree_item):boolean;
begin
    Handler._eDATA_:=eData;
    Handler._eITEM_:=eItem;
    result:=Handler.Processing;
end;

function tSrcTree_prcHandler._EXECUTE_4NODE_(const eParent:tSrcTree_itmHandler; const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer; const eItem:tSrcTree_item):boolean;
var Handler:tSrcTree_itmHandler;
begin
    Handler:=tHandler.Create(self,eParent);
    result :=_EXECUTE__NODE_(Handler,eData,eItem);
    Handler.FREE;
end;

//------------------------------------------------------------------------------

function tSrcTree_prcHandler._EXECUTE__TREE_(const Handler:tSrcTree_itmHandler; const eData:pointer; const eItem:tSrcTree_item):boolean;
var tmp:tSrcTree_item;
begin // глупо и тупо рекурсией
    //--- сначала СЕБЯ
    result:=_EXECUTE__NODE_(Handler,eData,eItem);
    //--- пошли по детям
    tmp:=eItem.ItemCHLD;
    while Assigned(tmp) do begin
        result:=_EXECUTE__TREE_(Handler,eData,tmp);
        if not result then BREAK;
        tmp:=tmp.ItemNEXT;
    end;
end;

function tSrcTree_prcHandler._EXECUTE_4TREE_(const eParent:tSrcTree_itmHandler; const tHandler:tSrcTree_itmHandler_TYPE; const eData:pointer):boolean;
var Handler:tSrcTree_itmHandler;
begin
    Handler:=tHandler.Create(self,eParent);
    result :=_EXECUTE__TREE_(Handler,eData,_nodeRoot_);
    Handler.FREE;
end;

//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler._EXECUTE_4ROOT_(const Handler:tSrcTree_itmHandler_TYPE);
var tmp:pointer;
begin
    tmp:=nil;
   _EXECUTE_4NODE_(nil,Handler,tmp,_nodeRoot_);
end;

//------------------------------------------------------------------------------

procedure tSrcTree_prcHandler._make_log_Start_;
begin
  (* _CNTs_CLN_;
    {$ifdef _DEBUG_}DEBUG('CopyRAST START',DateTimeToStr(NOW));{$endIf}
   _time_:=GetTickCount64;*)
end;

procedure tSrcTree_prcHandler._make_log_onEND_;
begin
   (*_time_:=GetTickCount64-_time_;
    //---
    {$ifdef _DEBUG_}DEBUG('CopyRAST  STOP',DateTimeToStr(NOW)+' running time: '+inttostr(round(_time_/1000)));{$endIf}
    //---
    {$ifdef _DEBUG_}DEBUG('tryEXE: '+inttostr(_all_tryEXE_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_missed_+': '+inttostr(_cnt_MISSED_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_noNeed_+': '+inttostr(_cnt_NoNeed_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT_passed_+': '+inttostr(_cnt_PASSED_));{$endIf}
    {$ifdef _DEBUG_}DEBUG(_c_onEvent_TXT__Error_+': '+inttostr(_cnt_ERRORs_));{$endIf}
    //---
    if _err_TEXT_<>'' then begin
        {$ifdef _DEBUG_}DEBUG('last ERR text: '+_err_TEXT_);{$endIf}
    end;
    //---
   *)
end;

//------------------------------------------------------------------------------



end.

