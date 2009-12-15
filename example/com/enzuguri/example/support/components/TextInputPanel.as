package com.enzuguri.example.support.components 
{
	import com.enzuguri.example.support.events.PanelEvent;

	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	/**
	 * @author alex
	 */
	[Wire(dispatch="sendText")] 
	public class TextInputPanel 
		extends Sprite 
	{
		private var field : TextField;
		private var button : Sprite;

		public function TextInputPanel()
		{
			init();
		}
		
		private function init() : void
		{
			field = new TextField();
			field.width = 200;
			field.height = 22;
			field.border = true;
			field.borderColor = 0x00;
			field.type = TextFieldType.INPUT;
			
			button = new Sprite();
			button.y = 60;
			button.buttonMode = true;
			button.addEventListener(MouseEvent.CLICK, button_clickHandler);
			
			var g:Graphics = button.graphics;
			g.beginFill(0x555555);
			g.drawRoundRect(0, 0, 80, 36, 6);
			g.endFill();
			
			
			addChild(field);
			addChild(button);
		}

		private function button_clickHandler(event : MouseEvent) : void
		{
			dispatchEvent(new PanelEvent(PanelEvent.SEND_TEXT, text));
		}
		
		public function get text():String
		{
			return field.text;
		}
		
		public function set text(value:String):void
		{
			field.text = value;
		}
	}
}
