global with sharing class DragAndDropFileController {
Public List<Attachment> allFileList {get; set;} 
Public List<SelectOption> filesCountList {get; set;}  
Public static String myId {get;set;}
//Public static integer i;
//Public static string volume; 
//Public static integer vol;
Public String FileCount {get; set;} 
    public DragAndDropFileController(){
        myId = Apexpages.Currentpage().getParameters().get('id');  
    }  
   
/* @RemoteAction

    global static String saveFile(String filename, blob fileContent, String id) {
     
       String err = null;
      // list<attachment> attchfiles=[select id,parentid,name,body from attachment where parentId=:id order by createddate desc limit 1];
       try
        { string fname=filename.substringbefore('.');
          Attachment atch = new Attachment(); 
            integer i=1;
            integer vol=0;
            string volume;
                //system.debug('***Name'+a.name+'******filename'+filename);
                 if(attchfiles.size()==0){
                       atch.ParentId = id;
                      atch.Name = fname+'-V0';
                      atch.contenttype ='PNG'; 
                      atch.body = filecontent;
                      
                 }
                 else{
                    
                    
                     atch.ParentId = id;
                     atch.Name=fname;
                      volume=fname.substringAfter('-V');
                    system.debug('*****volume****'+volume);
                    //vol=integer.valueof(volume);
                     vol=vol+1;
                     atch.Name = fname+'-V'+vol;
                      atch.contenttype ='PNG'; 
                      atch.body = filecontent;
                 }
            
            insert atch;
              }
         
         catch(Exception e){
            err=e.getMessage();
        }
        return err;
     }  *****/
  
   @RemoteAction

    global static String saveFile(String filename, blob fileContent, String pid) {
          integer Count = 0;
       String err;
       list<attachment> attchfiles=[select id,parentid,name,body from attachment where parentId=:pid];
        try
           
        {   Attachment atch = new Attachment();
           
             string fname=filename.substringbeforeLast('.');
             string ext=filename.substringafter('.');
            for(attachment a:attchfiles){
                //system.debug('***Name'+a.name+'******filename'+filename);
                String aname = a.name.substringBeforeLast('-V');
                 if(aname==fname){
                     count = count+1;
                      /*volume=a.name.substringAfterLast('-V');
                      vol=integer.valueof(volume);
                      vol=vol+1;
                      atch.ParentId = id;
                      atch.Name = filename+'-V'+vol;
                      // atch.contenttype ='image/PNG'; 
                      atch.body = filecontent;*/
                 }
                /* else{
                      atch.ParentId = id;
                      atch.Name = fname+'-V1';
                     // atch.contenttype ='PNG'; 
                      atch.body = filecontent;
                 }*/
            }
            if(count > 0){
                atch.ParentId = pid;
                atch.Name = fname+'-V'+count+'.'+ext;
                 //atch.contenttype ='image/PNG'; 
                atch.body = filecontent;
            
            }
            else{
                atch.ParentId = pid;
                 atch.Name = fname+'-V0'+'.'+ext;
                 //atch.contenttype ='PNG'; 
                 atch.body = filecontent;
            }
            insert atch;
     }
         
         catch(Exception e){
            err=e.getMessage();
        }
        return err;
     }  
    
}