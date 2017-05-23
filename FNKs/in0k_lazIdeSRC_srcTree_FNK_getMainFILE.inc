//function SrcTree_getMainFILE(const item:tSrcTree_ROOT; const crtFnc:fSrcTree_getMainFILE_crtMainFILE; const crtBaseDIR:fSrcTree_getBaseDIR_crtBaseDIR):tSrcTree_MAIN;
var tmp:tSrcTree_BASE;
begin
    {$ifOpt D+}Assert(Assigned(item));{$endIf}
    {$ifOpt D+}Assert(Assigned(crtFnc));{$endIf}
    result:=SrcTree_fndMainFILE(item);
    if not Assigned(result) then begin //< ничего страшного, его еще просто НЕ добавляли
        tmp:=SrcTree_getBaseDIR(item,crtBaseDIR);
        result:=crtFnc('');
        SrcTree_insert_ChldFrst(tmp,result);
    end;
end;

