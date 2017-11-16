//function SrcTree_getFsFldrREL(const item:tSrcTree_ROOT; const folder:string; const crtFnc:xSrcTree_crtRelPATH_callBACK):tSrcTree_fsFLDR;
var str:string;
    tmp:tSrcTree_item;
begin
    if path='' then result:=item // достигли КОРНЯ
    else begin
        result:=SrcTree_getFsFldrREL(item,srcTree_fsFnk_ExtractFileDir(path),crtFLDR);
        if Assigned(result) then begin {todo: а иначе может быть????}
            // ищем СВОЕ имя среди его детей
            str   :=srcTree_fsFnk_ExtractFileName(path); //< имя, которое мы исчем
            tmp   :=result.ItemCHLD;
            while Assigned(tmp) do begin
                if (tmp is _tSrcTree_item_fsNodeFLDR_) and
                   (srcTree_fsFnk_NamesEqual(str,_tSrcTree_item_fsNodeFLDR_(tmp).fsName))
                then begin
                    result:=_tSrcTree_item_fsNodeFLDR_(tmp);
                    BREAK;
                end;
                tmp:=tmp.ItemNEXT;
            end;
            //
            if not Assigned(tmp) then begin //< ненашли => создаем и ВСТАВЛЯЕМ
                tmp:=SrcTree_add_FsFLDR(result,path,crtFLDR);
            end;
            result:=_tSrcTree_item_fsNodeFLDR_(tmp);
        end;
    end;
end;

