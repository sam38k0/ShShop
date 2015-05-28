package com.shshop.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.oreilly.servlet.multipart.FileRenamePolicy;
 
public class TimestampFileRenamePolicy implements FileRenamePolicy {
	private List<String> newFileNames = new ArrayList<>();
	
    @Override
    public File rename(File f) {
        String name = f.getName();
        String body = null;
        String ext = null;
 
        int dot = name.lastIndexOf(".");
        if (dot != -1) {
            ext = name.substring(dot);
        } else {
            ext = "";
        }
        body = Long.toString( System.currentTimeMillis() );
 
        File renameFile = new File( f.getParent(), body + ext );
         
        if( renameFile.exists() ){
            int count = 0;
            do {
                count++;
                String newName = body + count + ext;
                renameFile = new File(f.getParent(), newName);
            }while( renameFile.exists() && count < 9999 );
             
        }
        
        f.renameTo( renameFile );
        getNewFileNames().add(renameFile.getName());
        
        return renameFile;
         
    }

	public List<String> getNewFileNames() {
		return newFileNames;
	}
}