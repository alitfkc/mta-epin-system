-----------------------------------------------------
--RASTGELE KOD OLUŞTURMA
-----------------------------------------------------
harfler_sayilar_tablo = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "r",
    "s",
    "t",
    "u",
    "v",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "R",
    "S",
    "T",
    "U",
    "V",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
}

function rastgele_kod_ver(para)
    local a = 1
    kod = kod_baslik.."-"
    while ( a <= 20 ) do 
        b = math.random(#harfler_sayilar_tablo)
        a = a + 1
        kod = kod..harfler_sayilar_tablo[b]
    end
    while not (kod_kontrol_et(kod)) do 
        local a = 1
        kod = kod_baslik.."-"
        while ( a <= 20 ) do 
            b = math.random(#harfler_sayilar_tablo)
            a = a + 1
            kod = kod..harfler_sayilar_tablo[b]
        end
    end
    local kayit_kontrol = kodu_veri_tabanina_kaydet(kod,para)
    if not kayit_kontrol then 
        server_info(kod.." anahtarı kayıt edilmedi.","error",source)
    end
    return kod
end
-----------------------------------------------------

-----------------------------------------------------
-- KOD AKTİF ETME
-----------------------------------------------------
function epin_kullanma(anahtar)
    local oyuncu_hesap_isim = getAccountName(getPlayerAccount(source))
    local sonuc = epin_kullan(anahtar,oyuncu_hesap_isim)
    if sonuc == nil then 
        server_info("Böyle bir kod mevcut değil!","error",source)
    elseif not sonuc then 
        server_info("Bu kod daha önceden kullanılmış!","error",source) 
    else
        server_info("Hesabınıza "..sonuc.." para eklendi.","success",source)
    end
end
addEvent("epin_kullanma_s",true)
addEventHandler("epin_kullanma_s",root,epin_kullanma)
-----------------------------------------------------