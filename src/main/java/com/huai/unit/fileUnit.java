package com.huai.unit;

import jcifs.smb.SmbFile;

import java.util.List;

/**
 * @Author: laiyunjing
 * @Date: 2019/7/12 0012 17:10
 * @Version 1.0
 */
public class fileUnit {

    /*文件大小转为 B    KB   MB  GB*/
    public  static String convertFileSize(long size) {
        long kb = 1024;
        long mb = kb * 1024;
        long gb = mb * 1024;

        if (size >= gb) {
            return String.format("%.1f GB", (float) size / gb);
        } else if (size >= mb) {
            float f = (float) size / mb;
            return String.format(f > 100 ? "%.0f MB" : "%.1f MB", f);
        } else if (size >= kb) {
            float f = (float) size / kb;
            return String.format(f > 100 ? "%.0f KB" : "%.1f KB", f);
        } else
            return String.format("%d B", size);
    }

    /*遍历文件的路径*/
    public  static void iterateFolder(String filePath, List filePathList) throws Exception {
        SmbFile file = new SmbFile(filePath);

        if (file.exists()) {
            if (file.isDirectory()) {
                for (SmbFile smbFile : file.listFiles()) {
                    if (smbFile.isDirectory()) {
                        iterateFolder(smbFile.getPath(), filePathList);
                    }else {
                        filePathList.add(smbFile.getPath());
                    }
                }
            }else {
                filePathList.add(filePath);
            }
        }
    }

    //将摘要字节数组转换为md5值
    public static String formatByteArrayTOString(byte[] digest) {
        //创建sb用于保存md5值
        StringBuffer sb = new StringBuffer();
        int temp;
        for (int i=0;i<digest.length;i++) {
            //将数据转化为0到255之间的数据
            temp=digest[i]&0xff;
            if (temp < 16) {
                sb.append(0);
            }
            //Integer.toHexString(temp)将10进制数字转换为16进制
            sb.append(Integer.toHexString(temp));
        }
        return sb.toString();
    }



}
