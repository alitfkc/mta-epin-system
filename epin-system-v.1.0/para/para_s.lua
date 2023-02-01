function oyuncu_parasi()
    local oyuncu_hesap_isim = getAccountName(getPlayerAccount(source))
    local oyuncu_parasi = oyuncu_parasini_getir(oyuncu_hesap_isim)
    triggerClientEvent("oyuncu_parayi_gonder",source,oyuncu_parasi)
end
addEvent("oyuncu_parayi_getir",true)
addEventHandler("oyuncu_parayi_getir",root,oyuncu_parasi)


function oyuncu_satin_alma_gecmisi()
    local oyuncu_hesap_isim = getAccountName(getPlayerAccount(source))
    local oyuncu_gecmis =  oyuncu_satin_alma_gecmisi_getir()
    triggerClientEvent("oyuncu_satin_alma_gecmisi_gonder",source,oyuncu_gecmis,oyuncu_hesap_isim)
end
addEventHandler("onPlayerLogin",root,oyuncu_satin_alma_gecmisi)