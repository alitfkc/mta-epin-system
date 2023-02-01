local market_buton_spam_s= 0
local secilen_buton = nil
function market_butona_basma()
    if (getTickCount() - market_buton_spam_s <= 500) then return  end -- bilmediğim bir şey yüzünden çift tıklıyor hep benim mouse ile alakalı olabilir ondan onu burada engelledim
    if (getTickCount() - market_buton_spam_s <= 3000) then return client_info("Lütfen biraz bekle.","info") end --Bu da aynı anda sürekli bir şey alarak buga sokmasınlar diye 3 sn süre koydum
    for k,v in ipairs(market_buton_tablo) do 
        if v == source then 
            secilen_buton = source
            if dgsGetVisible(onay_window) then 
                dgsFocus(onay_window)
                dgsMoveToBack(ana_panel_w)
                return
            else
                dgsSetVisible(onay_window,true)
                dgsFocus(onay_window) 
                dgsMoveToBack(ana_panel_w)
                return
            end
        end
    end
    secilen_buton = nil
    dgsSetVisible(onay_window,false)
end
function satis_onay()
    for k,v in ipairs(market_buton_tablo) do 
        if v == secilen_buton then 
            market_buton_spam_s = getTickCount()
            triggerServerEvent("satin_alma_c",localPlayer,market_urunler_tablo[k][3],market_urunler_tablo[k][4],market_urunler_tablo[k][5],market_urunler_tablo[k][6],market_urunler_tablo[k][7],market_urunler_tablo[k][8],market_urunler_tablo[k][9] or false)
            triggerServerEvent("oyuncu_parayi_getir",localPlayer)
        end
    end
end