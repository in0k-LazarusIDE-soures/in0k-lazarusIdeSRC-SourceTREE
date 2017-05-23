//function SrcTree_setBaseDIR(const item:tSrcTree_ROOT; const baseDir:string; const crtFnc:xSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    result:=SrcTree_getBaseDIR(item,crtFnc);
    SrcTree_re_set_itemTEXT(result,baseDir);
end;

