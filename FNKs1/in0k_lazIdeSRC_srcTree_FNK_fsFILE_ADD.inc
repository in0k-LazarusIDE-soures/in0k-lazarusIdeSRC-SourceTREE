//function SrcTree_addFsFILE(const item:tSrcTree_ROOT; const FilePath:string; const fileKind:TPkgFileType; const crtFnc:xSrcTree_crt_FsFILE_callBACK):_tSrcTree_item_fsNodeFILE_;
begin
    {$ifOpt D+}
      Assert(Assigned(item),'item Is NIL.');
      Assert(Path<>'','Path Is EMPTY.');
      Assert(Assigned(crtFILE),'crtFnc Is NIL.');
    {$endIf}
    result:=crtFILE(path,fileKind);
    SrcTree_insert_ChldLast(item,result);
end;

