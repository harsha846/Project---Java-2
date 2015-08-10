/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mypackage.MysqlConnect;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

 /**
 * Servlet to handle File upload request from Client
 * @author Harsha
 */
 public class FileUploadHandler extends HttpServlet {
   private final String UPLOAD_DIRECTORY = "E:\\javawebapp\\HarshaCMS\\web\\resources\\users";
    //String relativeWebPath = "/resources/users";
    //String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        //process only if its multipart content
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                                         new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = new File(item.getName()).getName();
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                        //delete old photo
                        try{
                            String user_id = request.getSession().getAttribute("user_id").toString();
                            String q = "select user_photo user where user_photo like '%.%' and user_id = " + user_id;
                            ResultSet rs=MysqlConnect.getDbCon().query(q);
                            if(rs.next()){
                                File deleteFile = new File(UPLOAD_DIRECTORY + rs.getString("user_photo")) ;
                                // check if the file is present or not
                                if( deleteFile.exists() ){
                                    deleteFile.delete() ;
                                }
                            }
                        }catch(Exception ex){

                        }
                        //update database
                        try{
                            String user_id = request.getSession().getAttribute("user_id").toString();
                            String q = "update user set user_photo='" + name + "' where user_id = " + user_id;
                            MysqlConnect.getDbCon().insert(q);
                        }catch(Exception ex){

                        }
                    }
                }
           
               //File uploaded successfully
               request.setAttribute("message", "Image Uploaded Successfully");

            } catch (Exception ex) {
               request.setAttribute("message", "Image Upload Failed due to " + ex);
            }          
         
        }else{
            request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
    
        request.getRequestDispatcher("/result.jsp").forward(request, response);
     
    }
  
}
