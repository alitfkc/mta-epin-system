loadstring(exports.dgs:dgsImportFunction())()

---------------------------------------------------------------------
-- E-PİN PANEL
---------------------------------------------------------------------
local edit_tex = dxCreateTexture("resimler/edit.png")
buton_t.epin_edit = dgsCreateEdit(0.3,0.43,0.5,0.1,"Aktifleştirilecek kodu giriniz.",true,epin_tab_panel,tocolor(1,1,1,255),1.2,1.2,edit_tex,tocolor(255,255,255,255))
dgsSetFont(buton_t.epin_edit,"default-bold")
local harf_siniri = 21 + string.len(kod_baslik) 
dgsSetProperty(buton_t.epin_edit,"maxLength",harf_siniri)
dgsEditSetHorizontalAlign(buton_t.epin_edit,"center")
dgsEditSetCaretStyle(buton_t.epin_edit,1)
dgsSetProperty(buton_t.epin_edit,"caretColor",tocolor(1,1,1,255))

local buton_tex = dxCreateTexture("resimler/buton.png")
buton_t.epin_buton =  dgsCreateButton(0.425,0.55,0.25,0.12,"Kullan",true,epin_tab_panel,tocolor(255,255,255),2.2,2.2,buton_tex,buton_tex,buton_tex,tocolor(255,255,255,220),tocolor(255,255,255,155),tocolor(255,255,255,255))
dgsSetFont(buton_t.epin_buton,"default-bold")


epin_label = dgsCreateLabel(0.3,0.35,0.48,0.1,"E-pin Aktif Etme",true,epin_tab_panel,tocolor(255,255,255,255),1.5,1.5,1,1,tocolor(1,1,1,255),"center")
dgsSetFont(epin_label,"default-bold")
------------------------------------------------------------------------


------------------------------------------------------------------------
--KALAN KULLANIM PANEL
------------------------------------------------------------------------
satin_almalar_gridlist = dgsCreateGridList(0,0,1,0.45,true,cuzdan_tab_panel,25,tocolor(52, 52,52,120),tocolor(1,1,1,255),tocolor(243, 201, 67,250),tocolor(55,55,55,0),tocolor(243, 201, 67,150))
satin_almalar_alinan_urun_gridlist_col = dgsGridListAddColumn( satin_almalar_gridlist, "Satın Alınan", 0.6 )
satin_almalar_alim_tarihi_gridlist_col =  dgsGridListAddColumn( satin_almalar_gridlist, "Satın Alma Tarihi", 0.3 )

kalan_kullanimlar_gridlist = dgsCreateGridList(0,0.475,1,0.475,true,cuzdan_tab_panel,25,tocolor(52, 52,52,120),tocolor(1,1,1,255),tocolor(243, 201, 67,250),tocolor(55,55,55,0),tocolor(243, 201, 67,150))
kalan_kullanimlar_alinan_urun_gridlist_col = dgsGridListAddColumn( kalan_kullanimlar_gridlist, "Ürün", 0.6 )
kalan_kullanimlar_alim_tarihi_gridlist_col =  dgsGridListAddColumn( kalan_kullanimlar_gridlist, "Kalan Kullanim", 0.3 )
