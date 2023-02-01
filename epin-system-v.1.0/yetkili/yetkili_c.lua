yetkiler_tablo = {}
buton_spam = 0
function panel_acilis()
    if guiGetVisible(yetkili_w) then 
        guiSetVisible(yetkili_w,false)
        showCursor(false)
        for k,v in pairs(kod_olustur_gui_t) do 
            removeEventHandler ( "onClientGUIClick",v,yetkili_butona_basma)
        end
        for k,v in pairs(tablar) do 
            removeEventHandler ( "onClientGUITabSwitched",v,tablara_basma)
        end
        removeEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_arama_edit, edite_yazma) 
        if guiGetVisible(kod_olustur_gui_t.aktif_kullanimlar_window) then 
            guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,false)
        end
        removeEventHandler("onClientGUIDoubleClick",aktif_kullanimlar_gridlist,aktif_kullanimlar_cift_basma)
        removeEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_silme_edit, edite_yazma)
        removeEventHandler("onClientGUIDoubleClick",kod_olustur_gridlist,kod_olustur_cift_basma)
    else
        guiSetVisible(yetkili_w,true)
        showCursor(true)
        guiSetText(kod_olustur_gui_t.kod_olustur_para,"Para Miktarı Giriniz.")
        guiSetText(kod_olustur_gui_t.kod_olustur_adet,"Oluşturulacak Kod Sayısı Yazınız.")
        guiSetText(kod_olustur_gui_t.kod_olustur_memo,"Kodları buradan kopyalayabilirsiniz.")
        for k,v in pairs(kod_olustur_gui_t) do 
            addEventHandler ( "onClientGUIClick",v,yetkili_butona_basma)
        end
        for k,v in pairs(tablar) do 
            addEventHandler ( "onClientGUITabSwitched",v,tablara_basma)
        end
        guiSetText(kod_olustur_gui_t.aktif_kullanimlar_arama_edit,"Oyuncu Ara") 
        addEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_arama_edit, edite_yazma) 
        addEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_silme_edit, edite_yazma) 
        addEventHandler("onClientGUIDoubleClick",aktif_kullanimlar_gridlist,aktif_kullanimlar_cift_basma)
        addEventHandler("onClientGUIDoubleClick",kod_olustur_gridlist,kod_olustur_cift_basma)
        triggerServerEvent("aktif_kullanimlari_cek",localPlayer)
    end
end
function  yetkili_butona_basma()
    if (getTickCount() - buton_spam < 500) then return end -- bilinmeyen bir sebepten çift tıklıyor mousem ile alakalı olabilir diye düşündüm ama ne olur ne olmaz diye engel koydum
    if source == kod_olustur_gui_t.panel_kapat then 
        guiSetVisible(yetkili_w,false)
        showCursor(false)
        for k,v in pairs(kod_olustur_gui_t) do 
            removeEventHandler ( "onClientGUIClick",v,yetkili_butona_basma)
        end
        for k,v in pairs(tablar) do 
            removeEventHandler ( "onClientGUITabSwitched",v,tablara_basma)
        end
        removeEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_arama_edit, edite_yazma) 
        if guiGetVisible(kod_olustur_gui_t.aktif_kullanimlar_window) then 
            guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,false)
        end
        removeEventHandler("onClientGUIDoubleClick",aktif_kullanimlar_gridlist,aktif_kullanimlar_cift_basma)
        removeEventHandler("onClientGUIChanged",kod_olustur_gui_t.aktif_kullanimlar_silme_edit, edite_yazma)
        removeEventHandler("onClientGUIDoubleClick",kod_olustur_gridlist,kod_olustur_cift_basma)
    elseif source == kod_olustur_gui_t.kod_olustur_para then 
        if (guiGetText(kod_olustur_gui_t.kod_olustur_para) == "Para Miktarı Giriniz." ) then 
            guiSetText(kod_olustur_gui_t.kod_olustur_para,"")
        elseif (type(tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_para))) ~= "number") then
            guiSetText(kod_olustur_gui_t.kod_olustur_para,"")
        end
    elseif source == kod_olustur_gui_t.kod_olustur_adet then 
        if (guiGetText(kod_olustur_gui_t.kod_olustur_adet) == "Oluşturulacak Kod Sayısı Yazınız." ) then 
            guiSetText(kod_olustur_gui_t.kod_olustur_adet,"")
        elseif (type(tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_adet))) ~= "number") then
            guiSetText(kod_olustur_gui_t.kod_olustur_adet,"")
        end
    elseif source == kod_olustur_gui_t.kod_olustur_buton then
        if (type(tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_adet))) ~= "number") then
            client_info("Geçersiz Adet Sayısı!","error")
            return
        end 
        if (type(tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_para))) ~= "number") then
            client_info("Geçersiz Para Miktarı!","error")
            return
        end
        triggerServerEvent("kod_alma_istegi",localPlayer,tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_adet)),tonumber(guiGetText(kod_olustur_gui_t.kod_olustur_para)))
    elseif source == kod_olustur_gui_t.kod_olustur_memo then 
        local memo_yazi = guiGetText(kod_olustur_gui_t.kod_olustur_memo)
        if (memo_yazi == "Anahtarları buradan kopyalayabilirsiniz.\n") then return end
        setClipboard(memo_yazi)
        client_info("Anahtarkar Kopyalandı.","success")
    elseif source ==  kod_olustur_gui_t.kod_olustur_kod_kaldir_buton then 
        local secilen_c, secilen_r = guiGridListGetSelectedItem(kod_olustur_gridlist)
        local secilen_metin = guiGridListGetItemText(kod_olustur_gridlist,secilen_c, secilen_r)
        if secilen_metin == ""  then return client_info("Önce listeden bir anahtar seçiniz!","info") end
        triggerServerEvent("kod_sil",localPlayer,secilen_metin)
        triggerServerEvent("epin_tablosunu_cek",localPlayer)
    elseif source ==  kod_olustur_gui_t.aktif_kullanimlar_arama_edit then 
        guiSetText(kod_olustur_gui_t.aktif_kullanimlar_arama_edit,"")
    elseif source == kod_olustur_gui_t.aktif_kullanimlar_window then 
        guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,false)
    elseif source == kod_olustur_gui_t.aktif_kullanimlar_sure_sil_buton  then 
        local sure = guiGetText(kod_olustur_gui_t.aktif_kullanimlar_silme_edit)
        if sure == "" then return client_info("Lütfen silinecek süreyi yazın!","info") end
        if type(tonumber(sure)) ~= "number" then return client_info("Süre sadece sayı olabilir") end
        local selectedRow, selectedCol = guiGridListGetSelectedItem( aktif_kullanimlar_gridlist)
        if selectedRow < 0 then return end
        local oyuncu_isim = guiGridListGetItemText( aktif_kullanimlar_gridlist, selectedRow, selectedCol )
        local yetki = guiGridListGetItemText(aktif_kullanimlar_gridlist,selectedRow,aktif_kullanimlar_acl_column)
        triggerServerEvent("yetki_suresi_sil",localPlayer,oyuncu_isim,yetki,sure)
        guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,false)
        triggerServerEvent("aktif_kullanimlari_cek",localPlayer)
    elseif source == kod_olustur_gui_t.aktif_kullanimlar_silme_edit then    
        guiSetText(kod_olustur_gui_t.aktif_kullanimlar_silme_edit,"")
    end
    buton_spam = getTickCount()
end

function kod_olustur_cift_basma()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( kod_olustur_gridlist)
    local anahtar = guiGridListGetItemText( kod_olustur_gridlist, selectedRow, selectedCol )
    if anahtar == "" then return end
    setClipboard(anahtar)
    client_info("Anahtar Kopyalandı.","success")
end

function tablara_basma()
    if source == tablar.aktif_kullanimlar_tab then 
        triggerServerEvent("aktif_kullanimlari_cek",localPlayer)
    elseif source == tablar.kapali_kodlar_tab then 
        triggerServerEvent("epin_tablosunu_cek",localPlayer)
    elseif source == tablar.kod_olustur_tab  then 
        triggerServerEvent("aktif_kullanimlari_cek",localPlayer)
    end
end
function client_info(mesaj,durum)
    exports["meta-info"]:sendClientMessage(mesaj,durum)
end

function aktif_kullanimlar_cift_basma()
    local selectedRow, selectedCol = guiGridListGetSelectedItem( aktif_kullanimlar_gridlist)
    if selectedRow < 0 then return end
    if not  guiGetVisible( kod_olustur_gui_t.aktif_kullanimlar_window) then 
        guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,true)
        guiFocus(kod_olustur_gui_t.aktif_kullanimlar_window)
    end
end

function memo_kod_yaz(tablo)
    local kodlar = ""
    for k,v in pairs(tablo) do 
        kodlar = kodlar..v.."\n" 
    end
    triggerServerEvent("epin_tablosunu_cek",localPlayer)
    guiSetText(kod_olustur_gui_t.kod_olustur_memo,kodlar)
end

function epinleri_yaz(epin_tablo)
    guiGridListClear(kapali_kodlar_gridlist)
    guiGridListClear(kod_olustur_gridlist)
    for k,v in pairs(epin_tablo) do
        if tonumber(v.durum) == 1 then 
            local row = guiGridListAddRow(kapali_kodlar_gridlist,v.anahtar,tostring(v.para),v.kullanan)
            guiGridListSetItemColor(kapali_kodlar_gridlist,row,kapali_kodlar_para_miktar_column,0,255,0,255)
            guiGridListSetItemColor(kapali_kodlar_gridlist,row,kapali_kodlar_kullanan_column,255,0,0,255)
        else
           local row = guiGridListAddRow( kod_olustur_gridlist,v.anahtar,tostring(v.para))
           guiGridListSetItemColor(kod_olustur_gridlist,row,kod_olustur_para_miktar_column,0,255,0,255)
        end
    end
end

function edite_yazma()
    if source == kod_olustur_gui_t.aktif_kullanimlar_arama_edit then 
        local metin = guiGetText(kod_olustur_gui_t.aktif_kullanimlar_arama_edit)
        guiGridListClear(aktif_kullanimlar_gridlist)
        for k,v in ipairs(yetkiler_tablo) do 
            local hesap,acl,sure = unpack(v)
            if string.find(hesap,metin,1,true) then 
                local row = guiGridListAddRow(aktif_kullanimlar_gridlist,hesap,acl,sure)
                guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_oyuncu_column,127,127,255)
                guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_acl_column,0,255,0)
                guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_sure_column,255,0,0)
            end
        end
    elseif source == kod_olustur_gui_t.aktif_kullanimlar_silme_edit then 
        local sure = guiGetText(kod_olustur_gui_t.aktif_kullanimlar_silme_edit)
        if sure == "" then return end
        if type(tonumber(sure)) ~= "number" then 
            guiSetText(kod_olustur_gui_t.aktif_kullanimlar_silme_edit,"")
            client_info("Süre sadece sayı olabilir!","error")  
        end
    end
end

function yetki_sureleri(tablo)
    yetkiler_tablo = tablo
    guiGridListClear(aktif_kullanimlar_gridlist)
    for k,v in ipairs(tablo) do 
        local hesap,acl,sure = unpack(v)
        local row = guiGridListAddRow(aktif_kullanimlar_gridlist,hesap,acl,sure)
        guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_oyuncu_column,127,127,255)
        guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_acl_column,0,255,0)
        guiGridListSetItemColor(aktif_kullanimlar_gridlist,row,aktif_kullanimlar_sure_column,255,0,0)
    end
end
addEvent("yetki_sureleri_gonder",true)
addEventHandler("yetki_sureleri_gonder",localPlayer,yetki_sureleri)

addEvent("epinler_tablosu",true)
addEventHandler("epinler_tablosu",localPlayer,epinleri_yaz)

addEvent("memoya_kodlari_yazma",true)
addEventHandler("memoya_kodlari_yazma",localPlayer,memo_kod_yaz)


addEvent("panelAc" ,true)
addEventHandler("panelAc",localPlayer,panel_acilis)