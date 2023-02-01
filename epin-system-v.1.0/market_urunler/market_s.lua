function satin_alma_s(ucret,verilecek_acl,verilecek_sure,verilecek_para,arac,silah,veri)
    local oyuncu_hesap_isim = getAccountName(getPlayerAccount(source))
    local oyuncu_para = oyuncu_parasini_getir(oyuncu_hesap_isim)
    local mesaj = ""
    if oyuncu_para < ucret then return server_info("Yetersiz bakiye!","error",source) end
    --------------------------------------------------------------------
    -- EĞER AYNI YETKİYE SAHİPSE YENİ ALACAĞININ SÜRESİNİ ÜSTÜNE EKLEME
    --------------------------------------------------------------------
    local satin_alma_gecmis =  oyuncu_satin_alma_gecmisi_getir()
    local time = getRealTime()
    local yil = time.year
    local ay = time.month
    local gun = time.monthday
    local stamp = time.timestamp
    local verilecek_urun = ""
    if verilecek_acl then 
        for k,v in pairs(verilecek_acl) do 
            if  not v then break end
            olan_sure = getAccountData(getPlayerAccount(source),"meta-"..v)
            if olan_sure then
                olan_sure = fromJSON(olan_sure)
            else
                olan_sure = {}
                olan_sure.stamp = stamp
                olan_sure.kullanim_suresi = 0
            end
            if olan_sure.kullanim_suresi <= 0 then 
                olan_sure.kullanim_suresi = 0
            end
            olan_sure.kullanim_suresi = olan_sure.kullanim_suresi + verilecek_sure
            stamp = stamp + (olan_sure.kullanim_suresi - verilecek_sure)
            setAccountData(getPlayerAccount(source),"meta-"..v,toJSON(olan_sure)) --ÖNEMLİ
        end
    end
    if verilecek_acl then 
        for k,v in pairs(verilecek_acl) do 
            if v and not  isObjectInACLGroup ("user."..oyuncu_hesap_isim, aclGetGroup (v)) then 
                aclGroupAddObject (aclGetGroup(v), "user."..oyuncu_hesap_isim)
            end
        end
    end
    if verilecek_para then 
        givePlayerMoney(source,verilecek_para)
    end
    if silah then 
        local id,mermi = unpack(silah)
        giveWeapon(source,id,mermi)
        verilecek_urun = getWeaponNameFromID(id)
    end
    if arac then 
        triggerEvent("market_arac_satin_alma",source,oyuncu_hesap_isim,arac)
        verilecek_urun = arac.." ID'ye sahip aracı"
    end
    local kalan_para = oyuncu_para - ucret
    oyuncu_para_kaydet(kalan_para,oyuncu_hesap_isim)
    local tarih = tostring(gun).."/"..tostring(ay+1).."/"..tostring(yil+1900) 
    if verilecek_acl then
        for k,v in pairs(verilecek_acl) do 
            if  not v then break end
            local sure_sonuc = (((verilecek_sure/60)/60)/24)
            sure_sonuc = math.floor(sure_sonuc+0.5)
            -- saat hesabı
            sure_sonuc_s = (( verilecek_sure/60)/60)
            sure_sonuc_s = math.floor(sure_sonuc_s+0.5)
            -- dakika hesabı
            sure_sonuc_d = (verilecek_sure/60)
            sure_sonuc_d = math.floor(sure_sonuc_d+0.5)
            local yazi = ""
            if sure_sonuc > 0 then 
                yazi = " günlük "
            end
            if sure_sonuc_s > 0 and sure_sonuc <= 0  then 
                yazi = " saatlik "
                sure_sonuc = sure_sonuc_s
            end
            if sure_sonuc_d > 0 and sure_sonuc_s <= 0  then 
                yazi = " dakikalık "
                sure_sonuc = sure_sonuc_d
            end
            server_info(string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "").." Adlı oyuncu başarıyla " ..sure_sonuc..yazi..v.." aldı!","success",root)
        end
    end
    if verilecek_para then
        server_info("Başarıyla "..verilecek_para.." $ Oyun parası aldınız.","success",source)
    end
    if verilecek_urun ~= "" then
        server_info(string.gsub(getPlayerName(source), "#%x%x%x%x%x%x", "").." Adlı oyuncu başarıyla "..verilecek_urun.." aldı!","success",root)
    end
    if verilecek_acl then
        for k,v in ipairs(verilecek_acl) do 
            satin_alma_kaydet(oyuncu_hesap_isim,v,verilecek_sure,stamp,tarih,verilecek_para)
        end 
    end
    if arac then 
        satin_alma_kaydet(oyuncu_hesap_isim,tostring(arac),verilecek_sure,stamp,tarih,verilecek_para)
    end
    if veri then
        satin_alma_kaydet(oyuncu_hesap_isim,veri,verilecek_sure,stamp,tarih,verilecek_para)
    end
    local oyuncu_hesap_isim = getAccountName(getPlayerAccount(source))
    local oyuncu_gecmis =  oyuncu_satin_alma_gecmisi_getir()
    triggerClientEvent("oyuncu_satin_alma_gecmisi_gonder",source,oyuncu_gecmis,oyuncu_hesap_isim)
    local acl = getPlayerAcls(source)
    local sonuc_tablo = {}
    for k,v in ipairs(acl) do 
        local tablo = getAccountData(getPlayerAccount(source),"meta-"..v)
        if tablo then 
            tablo = fromJSON(tablo)
            table.insert(sonuc_tablo,{v,tablo.stamp,tablo.kullanim_suresi})
        end
    end
    triggerClientEvent("satin_almalari_ana_sure_gonder",source,sonuc_tablo)
end
function getPlayerAcls(player)
    local acls = {}
    local account = getPlayerAccount(player)
    if not account or isGuestAccount(account) then
        return acls
    end

    local accountName = getAccountName(account)
    for _, group in ipairs(aclGroupList()) do
        if isObjectInACLGroup("user." .. accountName, group) then
            local groupName = aclGroupGetName(group)
            table.insert(acls, groupName)
        end
    end
    return acls
end

function yetki_alma(_,hesap)
    local acl = getPlayerAcls(source)
    local sonuc_tablo = {}
    for k,v in ipairs(acl) do 
        local tablo = getAccountData(hesap,"meta-"..v)
        if tablo then 
            tablo = fromJSON(tablo)
            local time = getRealTime()
            local sure = time.timestamp - tablo.stamp
            sure = tablo.kullanim_suresi - sure
            table.insert(sonuc_tablo,{v,tablo.stamp,tablo.kullanim_suresi})
            if sure <= 0 then 
                if  isObjectInACLGroup ("user."..getAccountName(hesap), aclGetGroup (v)) then 
                    aclGroupRemoveObject (aclGetGroup(v), "user."..getAccountName(hesap))
                    setAccountData(hesap,"meta-"..v,false)
                end
            end
        end
    end
    triggerClientEvent("satin_almalari_ana_sure_gonder",source,sonuc_tablo)
end
function aclleri_kontrol_etme()
    local ana_durum = false
    for k,v in ipairs(market_urunler_tablo) do 
        if market_urunler_tablo[k][4] then 
            for k,v in pairs(market_urunler_tablo[k][4]) do 
                if v then 
                    local durum = aclGetGroup(v)
                    if not durum then 
                        ana_durum = true
                        outputChatBox(v.." Acl grubu bulunamadı. (Bu mesajı kurucuya bildirin!)",root,255,0,0)
                    end
                end
            end
        end
    end
    if ana_durum then 
        outputChatBox("Eksik acl olduğu için script otomatik durduruldu.",root,255,0,0)
        stopResource(getThisResource())
    end
end
aclleri_kontrol_etme()



addEventHandler("onPlayerLogin",root,yetki_alma)

addEvent("satin_alma_c",true)
addEventHandler("satin_alma_c",root,satin_alma_s)







