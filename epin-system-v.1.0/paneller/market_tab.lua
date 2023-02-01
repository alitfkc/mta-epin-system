loadstring(exports.dgs:dgsImportFunction())()
market_buton_tablo = {}
arka_kutu_tablo = {}
market_scroll = dgsCreateScrollPane(0,0,1,1,true,market_tab_panel)
market_resim_tablo = {}
local buton_texture = dxCreateTexture("resimler/buton.png")

local x,y = 0.15,0
for k,v in ipairs(market_urunler_tablo) do 
    if k == 1 then 
        if market_urunler_tablo[k][9] then 
            arka_kutu_tablo[k] = dgsCreateImage(x,y,0.75,0.45,"resimler/kutu.png",true,market_scroll,tocolor(255,255,255,120))
            if market_urunler_tablo[k][2] then 
                market_resim_tablo[k] = dgsCreateImage(0,0,1,1,market_urunler_tablo[k][2],true,arka_kutu_tablo[k])
                market_buton_tablo[k] = dgsCreateButton(0.37,0.7,0.25,0.25,market_urunler_tablo[k][1],true,  market_resim_tablo[k],tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
                dgsSetFont(market_buton_tablo[k],"arial")
            else
                market_buton_tablo[k] = dgsCreateButton(0.28,0.7,0.45,0.25,market_urunler_tablo[k][1],true,   arka_kutu_tablo[k] ,tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
                dgsSetFont(market_buton_tablo[k],"arial")
            end
            y = 0.15
            x = 0.5
        else
            arka_kutu_tablo[k] = dgsCreateImage(x,y,0.3,0.3,"resimler/kutu.png",true,market_scroll,tocolor(255,255,255,120))
            if market_urunler_tablo[k][2] then 
                market_resim_tablo[k] = dgsCreateImage(0,0,1,1,market_urunler_tablo[k][2],true,arka_kutu_tablo[k])
                market_buton_tablo[k] = dgsCreateButton(0.28,0.7,0.45,0.25,market_urunler_tablo[k][1],true,  market_resim_tablo[k],tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
                dgsSetFont(market_buton_tablo[k],"arial")
            else
                market_buton_tablo[k] = dgsCreateButton(0.28,0.7,0.45,0.25,market_urunler_tablo[k][1],true,   arka_kutu_tablo[k] ,tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
                dgsSetFont(market_buton_tablo[k],"arial")
            end
        end
    else 
        if x >= 0.5 then 
            y = y + 0.4
            x = 0.15
        else
            x = x + 0.45
        end
        arka_kutu_tablo[k] = dgsCreateImage(x,y,0.3,0.3,"resimler/kutu.png",true,market_scroll,tocolor(255,255,255,120))
        if market_urunler_tablo[k][2] then 
            market_resim_tablo[k] = dgsCreateImage(0,0,1,1,market_urunler_tablo[k][2],true,arka_kutu_tablo[k])
            market_buton_tablo[k] = dgsCreateButton(0.28,0.7,0.45,0.25,market_urunler_tablo[k][1],true,  market_resim_tablo[k],tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
            dgsSetFont(market_buton_tablo[k],"arial")
        else
            market_buton_tablo[k] = dgsCreateButton(0.28,0.7,0.45,0.25,market_urunler_tablo[k][1],true,   arka_kutu_tablo[k] ,tocolor(1,1,1,255),1.15,1.15,buton_texture,buton_texture,buton_texture,tocolor(255,255,255,255),tocolor(255,255,255,155),tocolor(255,255,255,255))
            dgsSetFont(market_buton_tablo[k],"arial")
        end
    end
end
