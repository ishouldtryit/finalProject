package com.kh.synergyZone.rest;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.synergyZone.configuration.CustomFileUploadProperties;
import com.kh.synergyZone.vo.WorkAttachVO;

import lombok.extern.slf4j.Slf4j;

@CrossOrigin
@RestController
@RequestMapping("/rest/attachment")
@Slf4j
public class AttachmentRestController {
	
	@Autowired
	private CustomFileUploadProperties customFileUploadProperties;
	
	private File dir;
	
 
	@PostConstruct
	public void init() {
		dir = new File(customFileUploadProperties.getPath());
		dir.mkdirs();
	}
	
	@PostMapping("/upload")
	public ResponseEntity<List<WorkAttachVO>> upload(MultipartFile[] uploadFile) {
		List<WorkAttachVO> list = new ArrayList<>();
		String uploadFolder = "C:/final/upload/kh11fb/";
		
		String uploadFolderPath = getFolder();
		
		// make folder ----------
		File uploadPath = new File(uploadFolder, getFolder());
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		//make yyyy/MM/dd folder
		
		for(MultipartFile multipartFile : uploadFile) {
			
			WorkAttachVO attachVO = new WorkAttachVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			log.debug(uploadFileName);
			
			
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			attachVO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachVO.setUuid(uuid.toString());
				attachVO.setUploadPath(uploadFolderPath);
				
//				if(checkImageType(saveFile)) {
//					attachVO.setFileType(true);
//					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
//					thumbnail.close();
//				}
				list.add(attachVO);
				System.out.print(list);
			}catch (Exception e) {
				e.printStackTrace();
			}//end catch
		}//end for
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	// 오늘 날짜의 경로를 문자열로 생성한다.
		private String getFolder() {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date date = new Date(0);
			
			String str = sdf.format(date);
			
			return str.replace("-", File.separator);
		}
		
//		private boolean checkImageType(File file) {
//			try {
//				String contentType = Files.probeContentType(file.toPath());
//				
//				return contentType.startsWith("image");
//			}catch(IOException e) {
//				e.printStackTrace();
//			}
//			return false;
//		}
		
		
		@GetMapping("/download")
		public ResponseEntity<Resource> download(@RequestHeader("User-Agent") String userAgent, String fileName){
			Resource resource = (Resource) new FileSystemResource("C:/final/upload/kh11fb/" + fileName);
			
			if(((File) resource).exists() == false) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
			String resourceName = ((FileSystemResource) resource).getFilename();
			
			String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
			
			HttpHeaders headers = new HttpHeaders();
			try {
				String downloadName = null;
				if(userAgent.contains("Trident")) {
					downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				}else if(userAgent.contains("Edge")) {
					downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
				}else {
					downloadName = new String(resourceOriginalName.getBytes("UTF-8"), "ISO-8859-1");
				}
				
				headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			}catch(UnsupportedEncodingException e){
				e.printStackTrace();
			}
			return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		}
		
		
		@PostMapping("/delete")
		public ResponseEntity<String> delete(String fileName){
			
			File file;
			
			try {
				file = new File("C:/final/upload/kh11fb/" + URLDecoder.decode(fileName, "UTF-8"));
				
				file.delete();
				
//				if(type.equals("image")) {
//					String largeFileName = file.getAbsolutePath().replace("s_", "");
//					log.info("largetFileName : " + largeFileName);
//					file = new File(largeFileName);
//					file.delete();
//				}
			}catch(UnsupportedEncodingException e) {
				e.printStackTrace();
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}
			
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
		}
		
		
}
