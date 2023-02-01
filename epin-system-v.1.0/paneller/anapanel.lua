loadstring(exports.dgs:dgsImportFunction())()
buton_t = {}
-- ANA PANEL
ana_panel_w = dgsCreateWindow(0,0,1,1,market_ismi,true,tocolor(255,255,255),45,false,tocolor(243, 201, 67,250),false,tocolor(1,1,1,220),5,true)
dgsSetFont(ana_panel_w,"bankgothic")
dgsWindowSetSizable ( ana_panel_w, false )
dgsWindowSetMovable ( ana_panel_w, false )


para_yazi_label = dgsCreateLabel(0.82,0.5,0.13,0.4,"Kullanılabilir Bakiye;",true,ana_panel_w,tocolor(255,255,255,255),1.5,1.5,1,1,tocolor(1,1,1,255),"center")
dgsSetFont(para_yazi_label,"default-bold")
para_label = dgsCreateLabel(0.82,0.53,0.13,0.4,"0"..para_birim_logo,true,ana_panel_w,tocolor(0,200,0,255),1.5,1.5,1,1,tocolor(1,1,1,255),"center")
dgsSetFont(para_label,"default-bold")
sunucu_resim = dgsCreateImage(0.769,0.24,0.23,0.23,"resimler/sunucu_logo.png",true,ana_panel_w,tocolor(255,255,255,255))

local market_icon_tex = dxCreateTexture("resimler/market_icon.png")
market_tab_panel = dgsCreateTabPanel(0.175,0.1,0.6,0.75,true,ana_panel_w,20,false,tocolor(128,128,128,0))
buton_t.market_tab_buton = dgsCreateButton(0.02,0.34,0.07,0.1,"",true,ana_panel_w,tocolor(255,255,255),1,1,market_icon_tex,market_icon_tex,market_icon_tex,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
dgsSetVisible(market_tab_panel,true)

local epin_icon_tex = dxCreateTexture("resimler/epin_icon.png")
epin_tab_panel = dgsCreateTabPanel(0.175,0.1,0.6,0.75,true,ana_panel_w,20,false,tocolor(128,128,128,0))
buton_t.epin_tab_buton = dgsCreateButton(0.02,0.45,0.07,0.1,"",true,ana_panel_w,tocolor(255,255,255),1,1,epin_icon_tex,epin_icon_tex,epin_icon_tex,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
dgsSetVisible(epin_tab_panel,false)

local cuzdan_icon_tex = dxCreateTexture("resimler/cuzdan_icon.png")
cuzdan_tab_panel = dgsCreateTabPanel(0.175,0.1,0.6,0.75,true,ana_panel_w,20,false,tocolor(128,128,128,0))
buton_t.cuzdan_tab_buton = dgsCreateButton(0.02,0.56,0.07,0.1,"",true,ana_panel_w,tocolor(255,255,255),1,1,cuzdan_icon_tex,cuzdan_icon_tex,cuzdan_icon_tex,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
dgsSetVisible(cuzdan_tab_panel,false)

dgsSetVisible(ana_panel_w,false)



---------------------------------
--ONAY PANEL
---------------------------------
onay_window = dgsCreateWindow(0.3,0.4,0.35,0.15,"Satın almayı onaylıyor musunuz?",true,tocolor(1,1,1),35,false,tocolor(243,201,67,250),false,tocolor(1,1,1,220),5,true)
dgsSetFont(onay_window,"arial")
dgsWindowSetSizable ( onay_window, false )
dgsWindowSetMovable ( onay_window, false )
buton_t.onay_buton = dgsCreateButton(0.015,0.1,0.47,0.45,"ONAYLA",true,onay_window,tocolor(255,255,255),1,1,false,false,false,tocolor(0,128,0,255),tocolor(0,128,0,180),tocolor(0,128,0,100))
buton_t.red_buton = dgsCreateButton(0.52,0.1,0.47,0.45,"REDDET",true,onay_window,tocolor(255,255,255),1,1,false,false,false,tocolor(128,0,0,255),tocolor(128,0,0,180),tocolor(128,0,0,100))

dgsSetVisible(onay_window,false)