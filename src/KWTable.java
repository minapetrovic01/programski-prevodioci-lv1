import java.util.Hashtable;
public class KWTable {

	private Hashtable<String, Integer> mTable;
	public KWTable()
	{
		mTable = new Hashtable<String, Integer>();
		mTable.put("main", new Integer(sym.MAIN));
		mTable.put("int", new Integer(sym.INT));
		mTable.put("char", new Integer(sym.CHAR));
		mTable.put("float", new Integer(sym.FLOAT));
		mTable.put("bool", new Integer(sym.BOOL));
		mTable.put("loop", new Integer(sym.LOOP));
		mTable.put("redo", new Integer(sym.REDO));
	}
	
	public int find(String keyword)
	{
		Object symbol = mTable.get(keyword);
		if (symbol != null)
			return ((Integer)symbol).intValue();
		
		return sym.ID;
	}
	
}
