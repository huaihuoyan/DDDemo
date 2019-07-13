package com.huai.web.service.impl;

import com.huai.unit.fileUnit;
import com.huai.web.service.shareService;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import jcifs.smb.SmbFileInputStream;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.MalformedURLException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/12 0012 17:24
 * @Version 1.0
 */
@Service
public class shareServiceImpl implements shareService {

    @Value("${shareFolder.userName}")
    private String userName;

    @Value("${shareFolder.password}")
    private String password;

    @Value("${shareFolder.ip}")
    private String ip;

    @Value("${shareFolder.folderName}")
    private String folderName;


    @Value("${environ.upload.url}")
    private String lujin;

    private static MessageDigest md;
    /*md5 初始对象*/
    static {
        try {
            //初始化摘要对象
            md = MessageDigest.getInstance("md5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
    /*共享文件读取*/
    @Override
    public void file() {

        StringBuilder builder = new StringBuilder();
        builder.append("smb://");
        builder.append(this.userName);
        builder.append(":");
        builder.append(this.password);
        builder.append("@");
        builder.append(this.ip);
        builder.append(this.folderName);
        builder.append("/");

        BufferedInputStream inputStream = null;
        BufferedOutputStream outputStream = null;
        BufferedInputStream inputStream1 = null ;


        /*地址*/
        List<String> filepath =new ArrayList<>();
        /*把地址写入filepath里面*/
        try {
            fileUnit.iterateFolder(builder.toString(), filepath);
        } catch (Exception e) {
            e.printStackTrace();
        }

        for (String f : filepath) {
            try {
                SmbFile file = new SmbFile(f);
                String name = f.substring(f.lastIndexOf("/")+1);
                inputStream = new BufferedInputStream(new SmbFileInputStream(file)); //对文件进行读取
                int length = file.getContentLength();  //获取文件的内容大小
                byte[] buffer = new byte[length];
                /*生成MD5*/
                int len=-1;
                while ((len = inputStream.read(buffer)) != -1) {
                    md.update(buffer, 0, len);
                }

                byte[] digest = md.digest();
                //清空摘要数据，以便下次使用
                md.reset();
                String md5 = fileUnit.formatByteArrayTOString(digest);

                File filelocal = new File(lujin+"/"+md5+name);
                File fileParent = filelocal.getParentFile();
                if(!fileParent.exists()){
                    fileParent.mkdirs();
                }
                filelocal.createNewFile();


                inputStream1 = new BufferedInputStream(new SmbFileInputStream(file));
                outputStream = new BufferedOutputStream(new FileOutputStream(filelocal));
                int n = -1;
                while ((n = inputStream1.read(buffer)) != -1) {
                    outputStream.write(buffer,0,n);  //开始写
//                                    String str = new String(buffer,0,n,"UTF-8");
//                                    System.out.println(str);
                }
                outputStream.flush();



            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (SmbException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }finally {
                try {
                    if(outputStream != null){
                        outputStream.close();
                    }
                    if(inputStream != null){
                        inputStream.close();
                    }
                    if(inputStream1 != null){
                        inputStream1.close();
                    }

                } catch (IOException e) {
                    e.printStackTrace();
                }

            }

        }



    }
}
