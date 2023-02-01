function panel(thePlayer)
    local hesap = getAccountName ( getPlayerAccount ( thePlayer ) ) 
        if isObjectInACLGroup ("user."..hesap, aclGetGroup (yetkili_panel_acma_yetki ) ) then
          triggerClientEvent(thePlayer, "panelAc" ,thePlayer)
       end
end

function kod_alma(adet,para)
    local a = 1
    local kodlar ={}
    while (a <= adet) do 
        a = a + 1 
        kodlar[a] = rastgele_kod_ver(para)
    end
    triggerClientEvent("memoya_kodlari_yazma",source,kodlar)
end

function server_info(mesaj,durum,kisi)
    exports["meta-info"]:sendServerMessage(mesaj,durum,kisi)
end

function kod_listesi()
    local epin_tablo = epinler()
    triggerClientEvent("epinler_tablosu",source,epin_tablo)
end

function kod_silme(kod)
    local durum = kod_sildir(kod)
    if not durum then 
        server_info("Kod silinirken bir hata oluştu META SCRİPT ile iletişime geçiniz. (HATA DB'DEN KAYNAKLI OLABİLİR","error",source)
    end
end

function aktif_kullanimlar_s()
    local hesaplar = getAccounts()
    local sonuc_tablo = {}
    for k, v in ipairs(hesaplar) do 
        local aclleri = aclleri_getir(v)
        for lk, lv in ipairs(aclleri) do 
            local tablo = getAccountData(v,"meta-"..lv)
            if tablo then 
                tablo = fromJSON(tablo)
                local time = getRealTime()
                local sure = time.timestamp - tablo.stamp
                sure = tablo.kullanim_suresi - sure
                table.insert(sonuc_tablo,{getAccountName(v),lv,sure})
            end
        end
    end
    triggerClientEvent("yetki_sureleri_gonder",source,sonuc_tablo)
end

function aclleri_getir(account) 
    local acls = {}
    local accountName = getAccountName(account)
    for _, group in ipairs(aclGroupList()) do
        if isObjectInACLGroup("user." .. accountName, group) then
            local groupName = aclGroupGetName(group)
            table.insert(acls, groupName)
        end
    end
    return acls
end

function yetki_sure_sil_s(oyuncu_isim,yetki,sure)
    local hesaplar = getAccounts()
    for k, v in ipairs(hesaplar) do 
        if getAccountName(v) == oyuncu_isim then 
            local tablo = getAccountData(v,"meta-"..yetki)
            if tablo then
                tablo = fromJSON(tablo) 
                tablo.kullanim_suresi = tablo.kullanim_suresi - tonumber(sure)
                sure_db_silme(oyuncu_isim,yetki,sure)
                setAccountData(v,"meta-"..yetki,toJSON(tablo))
            end
        end
    end
end

function sure_db_silme(oyuncu_isim,yetki,sure)
    local s_t_tablo = oyuncu_satin_alma_gecmisi_getir()
    s_t_tablo = table.reverse(s_t_tablo )
    for k,v in ipairs(s_t_tablo) do 
        if v.alinan_urun == yetki then 
            kalan_kullanim_suresi =  v.kullanim_suresi  - sure
            if kalan_kullanim_suresi < 0 then kalan_kullanim_suresi = 0 end
            sure = sure - v.kullanim_suresi
            satin_alma_gecmis_duzenle(v.oyuncu,v.alinan_urun,v.satin_alma_stamp,kalan_kullanim_suresi,v.satin_alma_tarih)
            if sure <= 0 then break end
        end
    end
end

function table.reverse(t) 
    local reversedTable = {} 
    local itemCount = #t  
    for k, v in ipairs(t) do 
        reversedTable[itemCount + 1 - k] = v  
    end 
    return reversedTable  
end 

addEvent("yetki_suresi_sil",true)
addEventHandler("yetki_suresi_sil",root,yetki_sure_sil_s)

addEvent("aktif_kullanimlari_cek",true)
addEventHandler("aktif_kullanimlari_cek",root,aktif_kullanimlar_s)


addEvent("epin_tablosunu_cek",true)
addEventHandler("epin_tablosunu_cek",root,kod_listesi)

addEvent("kod_sil",true)
addEventHandler("kod_sil",root,kod_silme)
addEvent("kod_alma_istegi",true)
addEventHandler("kod_alma_istegi",root,kod_alma)

addCommandHandler ( yetkili_panel_acma_komut, panel ) 


