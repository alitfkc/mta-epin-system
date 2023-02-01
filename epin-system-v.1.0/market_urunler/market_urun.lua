market_urunler_tablo ={
    --{"ÜRÜN BUTON ÜSTÜ İSİM","ÜRÜN RESMİ (EĞER YOKSA FALSE YAZIN)",FİYAT,verilecek ACL(oyun parasıyla false yazın),sureli ise süre(saniye olarak yazın),verilecek para(0 ise FALSE yazın),araçise id yazın araç yoksa false yapın,silahid{silah_id,mermi} eğer verilmeyecekse false yazın},
    --{"ürün_isim",ürün_resim_klasörü,fiyat,acl,süre,para,arac_id,{silah_id,mermi}}
    ---------------------------------------------------------------------------------------------------------------------------------------
    --                ÖRNEKLER
    ---------------------------------------------------------------------------------------------------------------------------------------
    --{"Bronz VIP (1-AY)\n 50$","market_urunler/market_resimler/bilgisayar.png",50,"BronzVIP",2592000,false,false},
    --{"Bronz VIP (1-AY) \n 50"..para_birim_logo,"market_urunler/market_resimler/bilgisayar.png",50,"BronzVIP",2592000,false,false},
    --{"Gold VIP (1-AY) \n 50"..para_birim_logo,"market_urunler/market_resimler/iphone.png",50,"GoldVIP",2592000,false,false},
    --{"Silver VIP (1-AY) \n 50"..para_birim_logo,"market_urunler/market_resimler/scooter.png",50,"SilverVIP",2592000,false,false},
    --{"10000$ Oyun Parası \n 50"..para_birim_logo,"market_urunler/market_resimler/nargile.png",50,false,0,10000,false},
    ----------------------------------------------------------------------------------------------------------------------------------------
    --NOT : 1. ÜRÜNÜ VİTRİN YAPMAK İÇİN SONUNA  paket ismi yazın (YALNIZCA İLK ÜRÜN OLUR). 
    ----------------------------------------------------------------------------------------------------------------------------------------
    {"Bronz PAKET \n 1800"..para_birim_logo,"market_urunler/market_resimler/vitrin.png",370,{"tct"},2592000,1000,411,false,"Bronz PAKET"},
    {"Gold VIP (1-AY) \n 370"..para_birim_logo,"market_urunler/market_resimler/goldvip.png",370,{"tct","Moderator"},150,false,false,false},
    {"Bronze VIP(1-GüN) \n 100"..para_birim_logo,"market_urunler/market_resimler/bronzvip.png",100,{"Moderator"},24400,false,false,false},
    {"NİSSAN GT-R \n 1500"..para_birim_logo,"market_urunler/market_resimler/gtr.png",1500,{false},0,false,411,false},
    {"El bombası (50-ADET) \n 50"..para_birim_logo,"market_urunler/market_resimler/grenade.png",50,{false},0,false,false,{16,50}},
    {"1000$ \n 25"..para_birim_logo,"market_urunler/market_resimler/dollars.png",25,{false},0,1000,false,false},
}