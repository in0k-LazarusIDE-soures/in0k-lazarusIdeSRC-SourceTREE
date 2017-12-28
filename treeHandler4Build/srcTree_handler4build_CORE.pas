unit srcTree_handler4build_CORE;

{$mode objfpc}{$H+}

interface

uses
  srcTree_builder_CORE,
  srcTree_handler_CORE;

type

 tSrcTree_itmHandler4Build=class(tSrcTree_itmHandler)
  private
    function _get_Builder_:tSrcTree_Builder_CORE; {$ifOpt D-}inline;{$endIf}
  public
    property Builder:tSrcTree_Builder_CORE read _get_Builder_;
  end;

 tSrcTree_prcHandler4Build=class(tSrcTree_prcHandler)
  protected
   _builder_:tSrcTree_Builder_CORE;
  public
    constructor Create(const aBUILDer:tSrcTree_Builder_CORE); virtual;
  public
    property Builder:tSrcTree_Builder_CORE read _builder_;
  end;

implementation

function tSrcTree_itmHandler4Build._get_Builder_:tSrcTree_Builder_CORE;
begin
    result:=nil;
    if Assigned(_OWNER_) then result:=tSrcTree_prcHandler4Build(_OWNER_)._builder_;
end;

constructor tSrcTree_prcHandler4Build.Create(const aBUILDer:tSrcTree_Builder_CORE);
begin
    inherited Create;
   _builder_:=aBUILDer;
end;

end.

