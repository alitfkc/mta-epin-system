db = dbConnect( "sqlite", "data/data.db" )

global_table = {}
if db then 
    outputDebugString("Bağlantı başarılı")
end
---------------------------
-- Resource Start
--------------------------
function start_db_sc()
    local epin_tablo = dbPoll(dbQuery(db, "SELECT * FROM epin"),-1)
    local paralar_tablo = dbPoll(dbQuery(db, "SELECT * FROM paralar"),-1)
    local satin_alma_tablo = dbPoll(dbQuery(db, "SELECT * FROM satin_almalar"),-1)
    global_table.epin = toJSON(epin_tablo)
    global_table.money = toJSON(paralar_tablo)
    global_table.history = toJSON(satin_alma_tablo)
end

addEventHandler("onResourceStart",resourceRoot,start_db_sc)


-------------------------------------------
--KOD KONTROL ETME
-------------------------------------------
function kod_kontrol_et(kod)
    if db then 
        local epin_tablo = fromJSON(global_table.epin)
        for k,v in pairs(epin_tablo) do
            if v.anahtar == kod then 
                return false
            end
        end
        return true
    else
        outputDebugString("Database bağlantısı yok!")
    end
end

-------------------------------------------
--EPİNLERİ TABLOYA GÖNDERME
-------------------------------------------
function epinler()
    local epin_tablo = fromJSON(global_table.epin)
    return epin_tablo
end
-------------------------------------------
-- VERİYİ KAYDETME
-------------------------------------------
function table_add_epin(kod,m)
    local epin = fromJSON(global_table.epin)
    table.insert(epin,{anahtar=kod,para=m,durum=0,kullanan=nil})
    global_table.epin = toJSON(epin)
end

function kodu_veri_tabanina_kaydet(kod,para)
    local sonuc = dbExec(db,"INSERT INTO epin (anahtar,para,durum,kullanan) VALUES(?,?,?,?)",kod,para,false,nil)
    table_add_epin(kod,para,false,nil)
    return sonuc
end

-------------------------------------------
--VERİ SİLME 
-------------------------------------------
function kod_sildir(kod)
    local epin_tablom = fromJSON(global_table.epin)
    local durum = false
    for k,v in pairs(epin_tablom) do
        if v.anahtar == kod then 
            durum = dbExec(db, "DELETE FROM epin WHERE anahtar = ? AND para = ? ",v.anahtar,v.para,v.durum,v.kullanan)
            return durum
        end
    end
    return durum
end

-------------------------------------------
--EPİN KULLANMA
-------------------------------------------


function epin_kullan(anahtar,oyuncu_hesap_isim)
    if db then 
        local epin_tablo = fromJSON(global_table.epin)
        for k,v in pairs(epin_tablo) do
            if v.anahtar == anahtar then 
                if tonumber(v.durum) == 0 then 
                    local para_sonuc_i = 0
                    local paralar_tablo = fromJSON(global_table.money)
                    for nk,nv in pairs(paralar_tablo) do
                        if nv.oyuncu == oyuncu_hesap_isim then 
                            para_sonuc_i = nv.para
                            nv.para = para_sonuc_i + v.para
                            break
                        end
                    end
                    global_table.money = toJSON(paralar_tablo)
                    local para_sonuc = para_sonuc_i + v.para
                    dbExec(db,"UPDATE paralar SET para = ? WHERE oyuncu=? ",para_sonuc,oyuncu_hesap_isim)
                    dbExec(db, "UPDATE epin SET durum = ?,  kullanan = ? WHERE anahtar = ? AND para = ?",true,oyuncu_hesap_isim,anahtar,v.para)
                    v.durum = 1
                    global_table.epin = toJSON(epin_tablo)
                    return v.para
                elseif tonumber(v.durum) == 1 then
                    return false
                end
            end
        end
        return nil
    else
        outputDebugString("Database bağlantısı yok!")
    end
end

-------------------------------------------
--PARA VERİ GETİRME
-------------------------------------------
function oyuncu_parasini_getir(oyuncu_hesap_isim)
    if db then 
        local paralar_tablo = fromJSON(global_table.money)
        for k,v in pairs(paralar_tablo) do
            if v.oyuncu == oyuncu_hesap_isim then 
                return v.para
            end
        end
        dbExec(db,"INSERT INTO paralar (oyuncu, para) VALUES(?,?)",oyuncu_hesap_isim,0)
        return 0
    else
        outputDebugString("Database bağlantısı yok!")
    end
end

-------------------------------------------
-- PARA VERİSİ KAYDETME
-------------------------------------------
function table_add_money(account_name,pmoney)
    local money = fromJSON(global_table.money)
    for k,v in ipairs(money) do 
        if v.oyuncu == account_name then 
            v.para = pmoney
            print(pmoney)
        end
    end
    global_table.money = toJSON(money)
end
function oyuncu_para_kaydet(para_sonuc,oyuncu_hesap_isim)
    dbExec(db,"UPDATE paralar SET para = ? WHERE oyuncu=? ",para_sonuc,oyuncu_hesap_isim)
    table_add_money(oyuncu_hesap_isim,para_sonuc)
end

-------------------------------------------
-- SATIN ALMA KAYDETME
-------------------------------------------
function table_add_history(account_name,pacl,pstamp,timer,hist)
    local history = fromJSON(global_table.history)
    table.insert(history,{oyuncu=account_name,alinan_urun=pacl,satin_alma_stamp=pstamp,kullanim_suresi=timer,satin_alma_tarih=hist})
    global_table.history = toJSON(history)
end

function satin_alma_kaydet(oyuncu_hesap_isim,verilecek_acl,verilecek_sure,stamp,tarih,verilecek_para)
    if not verilecek_acl and verilecek_para then 
        verilecek_acl = tostring(verilecek_para.."$")
    end
    local sonuc = dbExec(db,"INSERT INTO satin_almalar (oyuncu,alinan_urun,satin_alma_stamp,kullanim_suresi,satin_alma_tarih) VALUES(?,?,?,?,?)",oyuncu_hesap_isim,verilecek_acl,stamp,verilecek_sure,tarih)
    table_add_history(oyuncu_hesap_isim,verilecek_acl,stamp,verilecek_sure,tarih)
    return sonuc
end

----------------------------------------
-- SATIN ALMA GEÇMİŞİ TABLO
----------------------------------------
function oyuncu_satin_alma_gecmisi_getir()
    local satin_alma_tablo = fromJSON(global_table.history)
    return satin_alma_tablo
end

----------------------------------------
-- SATİN ALMA VERİ DÜZENLEME
----------------------------------------
function  satin_alma_gecmis_duzenle(oyuncu,alinan_urun,satin_alma_stamp,kullanim_suresi,satin_alma_tarih)
    local sonuc = dbExec(db,"UPDATE satin_almalar SET kullanim_suresi = ?  WHERE oyuncu = ? AND alinan_urun = ? AND satin_alma_stamp = ? AND  satin_alma_tarih = ?",kullanim_suresi,oyuncu,alinan_urun,satin_alma_stamp,satin_alma_tarih)
    return sonuc
end