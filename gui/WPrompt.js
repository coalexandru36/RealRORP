
function WPrompt()
{
  this.div = document.createElement("div");
  this.div.classList.add("wprompt");
  this.div.style.position = "absolute";

  this.div_title = document.createElement("h1");
  this.div_area = document.createElement("textarea");
  var _this = this;
  this.div_area.onblur = function(){ _this.close(); }

  this.div_help = document.createElement("div");
  this.div_help.classList.add("help");
  
  this.div.appendChild(this.div_title);
  this.div.appendChild(this.div_area);
  this.div.appendChild(this.div_help);

  this.div_help.innerHTML = "APASA [TAB] PENTRU A FINALIZA";

  document.body.appendChild(this.div);

  this.div.style.display = "none";

  this.opened = false;
}

WPrompt.prototype.open = function(title,text)
{
  this.close(); 

  this.div_title.innerHTML = title;
  this.div_area.value = text;
  this.opened = true;
  this.div.style.display = "flex";

  this.div_area.focus();
}

WPrompt.prototype.close = function()
{
  if(this.opened){
    this.result = this.div_area.value;
    if(this.onClose)
      this.onClose();

    this.div_area.blur();
    this.opened = false;
    this.div.style.display = "none";
  }
}
