package org.apache.solr.common.utils
{
	public class NamedList
	{
		private var _children:Array;
		public var name:String;

		public function NamedList()
		{
			_children = new Array();
		}
		
		public function clear():void 
		{
			_children = new Array()
		}
		
		public function getValueAt(index:int):Object
		{
			return getEntry(index).value;
		}
		
		private function getEntry(index:int):NamedListEntry
		{
			return _children[index] as NamedListEntry;
		}
		
		public function add(name:String, value:Object):void
		{
			_children.push(new NamedListEntry(name,value));
		}
		
		public function setName(index:int, name:String):void 
		{
			getEntry(index).name = name;
		}
		
		public function getName(index:int):String 
		{
			return getEntry(index).name;
		}
		
		public function setValue(index:int, value:Object):void
		{
			getEntry(index).value = value;	
		}
		
		public function remove(index:int):void
		{
			_children.slice(index,1);
		}
		
		public function indexOf(name:String, start:int=0): int
		{
			for(var i:int = start; i < _children.length;i++)
			{
				var n:String = getName(i);
				if(n != null && n == name)
					return i;
			}
			return -1;
		}
		
		public function getValue(name:String, start:int=0): Object
		{
			for(var i:int = start; i < _children.length;i++)
			{
				var n:NamedListEntry = getEntry(i);
				if(n != null && n.name == name)
					return n.value;
			}
			return null;
		}
		
		public function getAllValues(name:String): Object
		{
			var result:Array = new Array();
			for(var i:int = 0; i < _children.length;i++)
			{
				var n:NamedListEntry = getEntry(i);
				if(n != null && n.name == name)
					result.push(n.value);
			}
			return result;
		}
		
		public function toString():String 
		{
			var s:String = "{";
			for(var i:int = 0; i < _children.length;i++)
			{
				if(i != 0)
					s +=",";
				var n:NamedListEntry = getEntry(i);
				s += n.name + "=" + n.value;
			}
			s += "}";
			return s;				
		}
		
		public function get children():Array
		{
			return _children;
		}
		
		public function get hasChildren():Boolean
		{
			return children.length > 0;
		}
			 
	}
}