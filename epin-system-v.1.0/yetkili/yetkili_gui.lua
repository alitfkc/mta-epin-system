kod_olustur_gui_t={}
tablar = {}

local function sistem_calisma_c()
    yetkili_w = guiCreateWindow(0.25,0.2,0.5,0.6,"Yetkili Panel",true)
    
    yetkili_tab = guiCreateTabPanel(0,0.05,1,0.95,true,yetkili_w)

    --Kod oluşturma ve Kullanılmamış Kodları gösterme
    tablar.kod_olustur_tab = guiCreateTab("Kod oluştur",yetkili_tab)

    
    kod_olustur_gui_t.panel_kapat = guiCreateButton(0.082,0.048,0.15,0.05,"Paneli Kapat",true,tablar.kod_olustur_tab) --Boşuna uğraşmamak için yukaridaki tabloya koydum oradan rahatça kapatacağım paneli

    guiSetProperty (kod_olustur_gui_t.panel_kapat, "NormalTextColour", "FFFF0000") 
    guiSetProperty (kod_olustur_gui_t.panel_kapat, "HoverTextColour", "FFF00FF00")
        --kod oluşturma
    kod_olustur_gui_t.kod_olustur_para = guiCreateEdit(0.015,0.2,0.3,0.08,"Para Miktarı Giriniz.",true,tablar.kod_olustur_tab)
    kod_olustur_gui_t.kod_olustur_adet = guiCreateEdit(0.015,0.3,0.3,0.08,"Oluşturulacak Kod Sayısı Yazınız.",true,tablar.kod_olustur_tab)
    kod_olustur_gui_t.kod_olustur_buton = guiCreateButton(0.015,0.4,0.3,0.08,"Oluştur",true,tablar.kod_olustur_tab)
    guiSetProperty (kod_olustur_gui_t.kod_olustur_buton, "NormalTextColour", "FF00FF00") 
    guiSetProperty (kod_olustur_gui_t.kod_olustur_buton, "HoverTextColour", "AA00FF00")
        --kod kopyalama 
    kod_olustur_gui_t.kod_olustur_memo = guiCreateMemo(0.015,0.5,0.3,0.4,"Anahtarları buradan kopyalayabilirsiniz.",true,tablar.kod_olustur_tab)
    guiMemoSetReadOnly(kod_olustur_gui_t.kod_olustur_memo,true)

        --Kullanılmayan Kodlar Gridlist
    kod_olustur_gridlist = guiCreateGridList(0.35,0.015,0.635,0.85,true,tablar.kod_olustur_tab)
    kod_olustur_kod_column = guiGridListAddColumn(kod_olustur_gridlist,"Anahtar",0.5)
    kod_olustur_para_miktar_column = guiGridListAddColumn(kod_olustur_gridlist,"Para",0.4)
    kod_olustur_gui_t.kod_olustur_kod_kaldir_buton = guiCreateButton(0.35,0.88,0.635,0.09,"Kaldır",true,tablar.kod_olustur_tab)
    guiSetProperty (kod_olustur_gui_t.kod_olustur_kod_kaldir_buton, "NormalTextColour", "FF00FF00") 
    guiSetProperty (kod_olustur_gui_t.kod_olustur_kod_kaldir_buton, "HoverTextColour", "FFFF0000")
    guiSetProperty (kod_olustur_gui_t.kod_olustur_kod_kaldir_buton, "Font", "default-bold-small")

    --Kullanılan kodlar
    tablar.kapali_kodlar_tab = guiCreateTab("Kullanılmış Kodlar",yetkili_tab)

    kapali_kodlar_gridlist = guiCreateGridList(0.015,0.015,0.97,0.97,true,tablar.kapali_kodlar_tab)
    kapali_kodlar_column = guiGridListAddColumn(kapali_kodlar_gridlist,"Anahtar",0.5)
    kapali_kodlar_para_miktar_column = guiGridListAddColumn(kapali_kodlar_gridlist,"Para",0.3)
    kapali_kodlar_kullanan_column = guiGridListAddColumn(kapali_kodlar_gridlist,"Kullanan Kişi",0.15)

    tablar.aktif_kullanimlar_tab = guiCreateTab("Aktif olan kullanımlar",yetkili_tab) -- ACCOUNT DATAYA KAYIT ETTİĞİMİZ İÇİN BU TABI AÇTIK
    -- AKTİF OLAN KULLANIMLAR
    aktif_kullanimlar_gridlist = guiCreateGridList(0.015,0.1,0.97,0.87,true,tablar.aktif_kullanimlar_tab)
    aktif_kullanimlar_oyuncu_column = guiGridListAddColumn(aktif_kullanimlar_gridlist,"Oyuncu",0.32)
    aktif_kullanimlar_acl_column = guiGridListAddColumn(aktif_kullanimlar_gridlist,"ACL-Group",0.32)
    aktif_kullanimlar_sure_column = guiGridListAddColumn(aktif_kullanimlar_gridlist,"Süre",0.3)

    kod_olustur_gui_t.aktif_kullanimlar_arama_edit = guiCreateEdit(0.018,0.015,0.3,0.085,"Oyuncu Ara",true,tablar.aktif_kullanimlar_tab)

    kod_olustur_gui_t.aktif_kullanimlar_window = guiCreateWindow(0.35,0.4,0.3,0.15,"Süre Silme(kapatmak için tıkla)",true)
    kod_olustur_gui_t.aktif_kullanimlar_silme_edit = guiCreateEdit(0.015,0.155,0.97,0.35,"Silenecek Süre",true,kod_olustur_gui_t.aktif_kullanimlar_window)
    kod_olustur_gui_t.aktif_kullanimlar_sure_sil_buton = guiCreateButton(0.015,0.535,0.97,0.35,"Kaldır",true,kod_olustur_gui_t.aktif_kullanimlar_window)
    guiSetProperty ( kod_olustur_gui_t.aktif_kullanimlar_sure_sil_buton, "NormalTextColour", "FFFF0000") -- Color format: AARRGGBB
    guiSetProperty ( kod_olustur_gui_t.aktif_kullanimlar_sure_sil_buton, "HoverTextColour", "FFFFFF00")
    
    guiSetVisible(kod_olustur_gui_t.aktif_kullanimlar_window,false)
    guiSetVisible(yetkili_w,false)

end
addEventHandler("onClientResourceStart",resourceRoot,sistem_calisma_c)