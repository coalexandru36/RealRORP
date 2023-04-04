local cfg = {}
cfg.open_wallet = 5000
cfg.open_bank = 40000

cfg.display_css = [[
  @font-face{
    font-family: fontcustom;
    src: url(fonts/fontcustom2.woff);
  }

  .div_money{
    position: fixed;
    font-family: "Montserrat";
    top: 19.44444vh;
    text-align: right;
    right: 1.04167vw;
    font-weight: 300;
    opacity: 90%;
    font-size: 0.91146vw;
    padding:5px 7.5px;
    color: #ffffff;
    text-shadow: -3px 2px 6px rgb(0 0 0 / 59%);
  }
  .div_bmoney{
    position: fixed;
    font-family: 'Montserrat';
    top: 21.75926vh;
    text-align: right;
    right: 1.04167vw;
    opacity: 90%;
    color: rgba(169,169,169,0.7);
    
    font-size: 0.91146vw;
    padding:5px 7.5px;
    color: #FFFFFF;
    text-shadow: -3px 2px 6px rgb(0 0 0 / 59%);
  }

  .div_donationCoins{
    position: fixed;
    font-family: 'Montserrat';
    top: 24.07407vh;
    text-align: right;
    right: 1.04167vw;
    opacity: 90%;
    color: rgba(169,169,169,0.7);
    
    font-size: 0.91146vw;
    padding:5px 7.5px;
    color: #FFFFFF;
    text-shadow: -3px 2px 6px rgb(0 0 0 / 59%);
  }

  -- .div_onlinePlayers{
  --   position: absolute;
  --   background-color: rgba(0,0,0,0.4);
  --   top: 153px;
  --   text-align:right;
  --   right: 10px;
  --   text-align:5px;
  --   padding: 7px;
  --   width : 170px;
  --   border-bottom-left-radius: 11px;
  --   border-bottom-right-radius: 11px;
  --   border-bottom: 1px solid lightskyblue;
  --   font-size: 17px;
  --   font-weight: light;
  --   font-family: fontcustom;
  --   color: #FFFFFF;
  -- }

--   .div_money .symbol{
--     content: url('https://cdn.discordapp.com/attachments/936273133701329007/936290191314939934/banknotes-24.png'); 
--     animation: logomove 2.1s infinite;]
--     float: inherit;
--     margin-left: 20px;
--   }
  
--   .div_bmoney .symbol{
--     content: url('https://cdn.discordapp.com/attachments/936273133701329007/936290285951004672/credit-card-6-24.png');
--     animation: logomove 2.1s infinite;
--     float: inherit;
--     margin-left: 20px;
--   }

--   .div_donationCoins .symbol{
--     content: url('https://cdn.discordapp.com/attachments/936273133701329007/936290047337066537/diamond-24.png');
--     animation: logomove 2.1s infinite;
--     float: inherit;
--     margin-left: 20px;
--   }

  -- .div_onlinePlayers .symbol{
  --   content: url('https://cdn.discordapp.com/attachments/936273133701329007/936290114160722000/conference-24.png');
  --   animation: logomove 2.1s infinite;
  --   float: left;
  --   margin-left: 5px;
  -- }

  
]]

return cfg