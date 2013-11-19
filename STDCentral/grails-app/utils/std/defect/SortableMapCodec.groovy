package std.defect

class SortableMapCodec {
	
	static encode = { map ->
		def x = [:]
		map.collectEntries( x ) { k, v ->
  			if ( v && ! (v instanceof Map) )
    			[k, v]
  			else
    			[:]
		}
		return x
	}

}