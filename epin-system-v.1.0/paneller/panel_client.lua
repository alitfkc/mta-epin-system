kapama_timer = false
function panel_ac_kapa()        
    if dgsGetVisible(ana_panel_w) then 
        dgsSetVisible(ana_panel_w,false)
        showCursor(false)
        showChat(true)
        for k,v in pairs(buton_t) do 
            removeEventHandler ( "onDgsMouseClick",v,ana_panel_butonlar)
        end
        for k,v in pairs(market_buton_tablo) do 
            removeEventHandler ( "onDgsMouseClick",v,market_butona_basma)
        end
        if dgsGetVisible(onay_window) then 
            dgsSetVisible(onay_window,false)
            secilen_buton = nil
        end
    else
        if isTimer(kapama_timer) then 
            killTimer(kapama_timer)
        end
        dgsSetVisible(ana_panel_w,true)
        dgsSetAlpha(ana_panel_w,0)
        dgsAlphaTo(ana_panel_w,1,"OutQuad",1000)  
        dgsSetProperty(buton_t.epin_edit,"maxLength",50)
        playSoundFrontEnd(1)
        dgsSetText(buton_t.epin_edit,"Aktifleştirilecek kodu giriniz.")
        local harf_siniri = 21 + string.len(kod_baslik) 
        dgsSetProperty(buton_t.epin_edit,"maxLength",harf_siniri)
        triggerServerEvent("oyuncu_parayi_getir",localPlayer)
        --getir
        showCursor(true)
        showChat(false)
        for k,v in pairs(buton_t) do 
            addEventHandler ( "onDgsMouseClick",v,ana_panel_butonlar)
        end
        for k,v in pairs(market_buton_tablo) do 
            addEventHandler ( "onDgsMouseClick",v,market_butona_basma)
        end
    end
end

local p_c_spam_engel = 0
function ana_panel_butonlar()
    if (getTickCount() - p_c_spam_engel <= 1000) then return end
    p_c_spam_engel = getTickCount()
    if source == buton_t.market_tab_buton then 
        if not dgsGetVisible(market_tab_panel) then 
            dgsSetVisible(market_tab_panel,true)
            dgsSetPosition(market_tab_panel,0.175,1,true)
            dgsMoveTo(market_tab_panel,0.175,0.11,true,"InOutBack",800)
        end
        if dgsGetVisible(epin_tab_panel) then 
            dgsMoveTo(epin_tab_panel,1,0.1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(epin_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(cuzdan_tab_panel) then 
            dgsMoveTo(cuzdan_tab_panel,1,0.1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(cuzdan_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(onay_window) then 
            dgsSetVisible(onay_window,false)
            secilen_buton = nil
        end
    elseif source == buton_t.epin_tab_buton then
        if dgsGetVisible(market_tab_panel) then 
            dgsMoveTo(market_tab_panel,0.175,1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(market_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(cuzdan_tab_panel) then 
            dgsMoveTo(cuzdan_tab_panel,1,0.1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(cuzdan_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(onay_window) then 
            dgsSetVisible(onay_window,false)
            secilen_buton = nil
        end
        if not dgsGetVisible(epin_tab_panel) then 
            dgsSetVisible(epin_tab_panel,true)
            dgsSetPosition(epin_tab_panel,1,0.1,true)
            dgsMoveTo(epin_tab_panel,0.175,0.1,true,"InOutBack",800)
        end
    elseif  source == buton_t.cuzdan_tab_buton then 
        if dgsGetVisible(market_tab_panel) then 
            dgsMoveTo(market_tab_panel,0.175,1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(market_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(epin_tab_panel) then 
            dgsMoveTo(epin_tab_panel,1,0.1,true,"InOutBack",800)
            setTimer(function()
                dgsSetVisible(epin_tab_panel,false)
            end,800,1)
        end
        if dgsGetVisible(onay_window) then 
            dgsSetVisible(onay_window,false)
            secilen_buton = nil
        end
        if not dgsGetVisible(cuzdan_tab_panel) then 
            dgsSetVisible(cuzdan_tab_panel,true)
            dgsSetPosition(cuzdan_tab_panel,1,0.1,true)
            dgsMoveTo(cuzdan_tab_panel,0.175,0.1,true,"InOutBack",800)
        end
        oyuncu_satin_alma_gecmis_yaz()
        aktif_kullanimlar_yaz()
    elseif source == buton_t.epin_edit then 
        if (dgsGetText(buton_t.epin_edit) == "Aktifleştirilecek kodu giriniz." ) then 
            dgsSetText(buton_t.epin_edit,"")
        end
    elseif source == buton_t.epin_buton then 
        if (dgsGetText(buton_t.epin_edit) == "Aktifleştirilecek kodu giriniz." ) then  return end
        local harf_siniri = 21 + string.len(kod_baslik) 
        if (string.len(dgsGetText(buton_t.epin_edit)) ~= harf_siniri) then 
            client_info("Hatalı Kod!","error")
            return
        end
        triggerServerEvent("epin_kullanma_s",localPlayer,dgsGetText(buton_t.epin_edit))
        triggerServerEvent("oyuncu_parayi_getir",localPlayer)
    elseif source == buton_t.onay_buton then 
        satis_onay()
        dgsSetVisible(onay_window,false)
        secilen_buton = nil
    elseif source == buton_t.red_buton then 
        dgsSetVisible(onay_window,false)
        secilen_buton = nil
    end
end

function oyuncu_parasi_yaz(oyuncu_parasi)
    dgsSetText(para_label,"")
    local a= dgsSetText(para_label,oyuncu_parasi..para_birim_logo)
end


function oyuncu_satin_alma_gecmis_yaz()
    dgsGridListClear(satin_almalar_gridlist)
    for k,v in pairs(satin_almalar_tablo_pc) do
        if hesap_isim == v.oyuncu then
            local gecici = tonumber(v.alinan_urun)
            if type(gecici) == "number"  then 
                if gecici > 0 then 
                    gecici = getVehicleNameFromModel(gecici)
                    local row = dgsGridListAddRow(satin_almalar_gridlist,1,v.alinan_urun.."-"..gecici,v.satin_alma_tarih)  
                end
            else
                local row = dgsGridListAddRow(satin_almalar_gridlist,1,v.alinan_urun,v.satin_alma_tarih)  
            end
        end
    end
end
function aktif_kullanimlar_yaz()
    dgsGridListClear(kalan_kullanimlar_gridlist)
    local time = getRealTime()
    for k,v in pairs(ana_yetki_sureler_tablo) do   
        local alinan_urun,alim_stamp,kullanim_suresi = unpack(v)
        local sure = time.timestamp - alim_stamp
        sure_sonuc = kullanim_suresi - sure
        -- GÜN HESABI
        sure_sonuc_g = ((( sure_sonuc/60)/60)/24)
        sure_sonuc_g = math.floor(sure_sonuc_g)

        -- saat hesabı
        sure_sonuc_s = (( sure_sonuc/60)/60)
        sure_sonuc_s = math.floor(sure_sonuc_s)

        -- dakika hesabı
        sure_sonuc_d = (sure_sonuc/60)
        sure_sonuc_d = math.floor(sure_sonuc_d)
        local yazi = "     -"

        if sure_sonuc_g > 0 then 
            yazi = tostring(sure_sonuc_g+1).."/gün"
        end
        if sure_sonuc_s > 0 and sure_sonuc_g <= 0  then 
            yazi = tostring(sure_sonuc_s+1).."/saat"
            sure_sonuc = 12
        end
        if sure_sonuc_d > 0 and sure_sonuc_s <= 0  then 
            yazi = tostring(sure_sonuc_d+1).."/dakika"
            sure_sonuc =  5
        end
        local row = dgsGridListAddRow(kalan_kullanimlar_gridlist,1,alinan_urun,yazi)
        if sure_sonuc >= 21  then 
            dgsGridListSetItemColor(kalan_kullanimlar_gridlist,row,kalan_kullanimlar_alim_tarihi_gridlist_col,0,255,0)
        elseif sure_sonuc <= 20 and sure_sonuc >= 11 then 
            dgsGridListSetItemColor(kalan_kullanimlar_gridlist,row,kalan_kullanimlar_alim_tarihi_gridlist_col,255,255,0)
        elseif sure_sonuc <= 10 and sure_sonuc >= 1 then 
            dgsGridListSetItemColor(kalan_kullanimlar_gridlist,row,kalan_kullanimlar_alim_tarihi_gridlist_col,255,0,0)
        end
    end
end
satin_almalar_tablo_pc = {}
hesap_isim = ""
local function satin_alma_tablo_kayit(gecmis_tablo_s,oyuncu_hesap_isim_s)
    satin_almalar_tablo_pc = gecmis_tablo_s
    hesap_isim = oyuncu_hesap_isim_s
end
addEvent("oyuncu_satin_alma_gecmisi_gonder",true)
addEventHandler("oyuncu_satin_alma_gecmisi_gonder",localPlayer,satin_alma_tablo_kayit)

addEvent("oyuncu_parayi_gonder",true)
addEventHandler("oyuncu_parayi_gonder",localPlayer,oyuncu_parasi_yaz)




ana_yetki_sureler_tablo = {}
function satin_alma_ana_sureler(t)
    ana_yetki_sureler_tablo = t
end

addEvent("satin_almalari_ana_sure_gonder",true)
addEventHandler("satin_almalari_ana_sure_gonder",localPlayer,satin_alma_ana_sureler)


bindKey(panel_acma_tus,"down",panel_ac_kapa)


