//function SrcTree_add_FsFLDR(const item:tSrcTree_item; const FolderPATH:string; const crtFnc:xSrcTree_crt_FsFLDR_callBACK):_tSrcTree_item_fsNodeFLDR_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL.');
      Assert(path<>'','Path Is EMPTY.');
      Assert(Assigned(crtFnc),'crtFnc Is NIL.');
    {$endIf}
    result:=crtFnc(path);
    SrcTree_insert_ChldLast(item,result);
end;

