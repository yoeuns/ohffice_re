<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="/ohffice/resources/start/vendor/jquery/jquery.min.js"></script>

<script async defer src="https://apis.google.com/js/api.js"></script>
<meta charset=UTF-8">
<meta name="google-signin-client_id"
	content="587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com">
<title>로딩</title>
<style type="text/css">
.wrap-loading { /*화면 전체를 가립니다.*/
	position: fixed;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	background: #ffffff; /*not in ie */
	filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000',
		endColorstr='#20000000'); /* ie */
}

.loadingimage {
    position: fixed;
    top: 21%;
    left: 36%;
    }

</style>
</head>
<script type="text/javascript">
      // Client ID and API key from the Developer Console
    var folderMap = new Map();
 	var CLIENT_ID = '587430510556-flm2n83bsnf2ij0kicq00f3p76omh8ou.apps.googleusercontent.com';
	var API_KEY = 'AIzaSyBhi9PSQYrFOw0MBWCZusHQFfawVxzU5Vc';
	var company = "<c:out value='${company.com_url}'/>";
	var companyName = "<c:out value='${company.com_name}'/>";
      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];
	
      // Authorization scopes required by the API; multiple scopes can be
      // included, separated by spaces.
      var SCOPES = 'https://www.googleapis.com/auth/drive';

      var authorizeButton = document.getElementById('authorize_button');
      var signoutButton = document.getElementById('signout_button');
      
      $(document).ready(function(){
    	
    	  $("#loading").css("display","");
    	  if(company == '' || company == null){
    		  alert("잘못된 접근방식입니다.");
    		  location.replace("main.do");
    		  }
      })

      /**
       *  On load, called to load the auth2 library and API client library.
       */
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      /**
       *  Initializes the API client library and sets up sign-in state
       *  listeners.
       */
      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          signoutButton.onclick = handleSignoutClick;
        });
      }

      /**
       *  Called when the signed in status changes, to update the UI
       *  appropriately. After a sign-in, the API is called.
       */
      function updateSigninStatus(isSignedIn){
        if (isSignedIn) { //googleLogin이 되었다면

          listFiles();
          var access_token =  gapi.auth.getToken().access_token;
          var request = gapi.client.request({
			   'path': '/drive/v2/files/',
			   'method': 'POST',
			   'headers': {
				   'Content-Type': 'application/json',
				   'Authorization': 'Bearer ' + access_token,             
			   },
			   'body':{
				   "title" : "[oh!ffice]"+companyName,
				   "mimeType" : "application/vnd.google-apps.folder",
			/* 	   "parents": [{
						"kind": "drive#file",
						"id": '1Bc-5FSaJxyTa69thtAwAa9HypA-q44C8'
					}] */
			   }
			});
           request.execute(function(resp) { 
			   if (!resp.error) {
				   console.log("level1 success")
				   folderMap.set(resp.title+"",resp.id);
				   second(resp.id, access_token)
			   }else{
				console.log("Error: " + resp.error.message);
			   }
			});      
        } else { //로그인이 되어있지 않다면
        	 alert("잘못된 접근방식입니다.");
        	 location.replace("main.do");
        }
      }
      
      
      async function second(file, access_token){ // level2

    	  request =gapi.client.request({
			   'path': '/drive/v2/files/',
			   'method': 'POST',
			   'headers': {
				   'Content-Type': 'application/json',
				   'Authorization': 'Bearer ' + access_token,             
			   },
			   'body':{
				   "title" : "workflow",
				   "mimeType" : "application/vnd.google-apps.folder",
				   "parents": [{
						"kind": "drive#file",
						"id": file,
					}]
			   }
			}); 
		  request.execute(function(resp) {
			  if (!resp.error) {
				  console.log("level2 success");
				  third(resp.id, access_token)
			  }else{
				  console.log("Error: " + resp.error.message);
			  }
		  });
      
      }
      async function third(file, access_token){ //level3
    	  var folders = [/* "게시판", */"공통양식","나의양식","자유기안"];
    	 
    		for(const element of folders){
    			
    		   request =gapi.client.request({
   			   'path': '/drive/v2/files/',
   			   'method': 'POST',
   			   'headers': {
   				   'Content-Type': 'application/json',
   				   'Authorization': 'Bearer ' + access_token,             
   			   },
   			   'body':{
   				   "title" : element,
   				   "mimeType" : "application/vnd.google-apps.folder",
   				   "parents": [{
   						"kind": "drive#file",
   						"id": file,
   					}]
   			   }
   			}); 
   			 request.execute(function(resp) {
   			  if (!resp.error) {
   				  console.log("level3 success");
   					  switch(element){
   				  		case "공통양식" :
   				  		 fourth_2(resp.id,access_token);
   				  		 break;
   				  		 default : 
   							folderMap.set(element,resp.id);
   				 	 	}
   				
   			  }else{
   				  console.log("Error: " + resp.error.message);
   			  }
   		  });
    	  }
    	  
      }
       /* async  function fourth_1(file,access_token){
    	 var folders = ["사내소식","전사공지","전사규정","전사자료","정보공유"];
    	 
   	  folders.forEach(function(element){
   		  request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file,
  					}]
  			   }
  			}); 
  		  request.execute(function(resp) {
  			  if (!resp.error) {
  				  console.log("level4-1 success");
  				  
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   	}); 
   	  return true;
     } */
      async function fourth_2(file,access_token){
    	 var folders = ["보고","업무","인사","재무","총무"];
    	 var index = 0;
    	 var mapFolderId = new Map;
    	 for(const element of folders){
    		
   		 request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file,
  					}]
  			   }
  			}); 
   	 await	request.execute(function(resp) {
   				
  			  if (!resp.error) {
  				  index++;
  					mapFolderId.set(element,resp.id);
  				  folderMap.set(element,resp.id);
  				  console.log("level4-2 success");
  				  if(index == 5){
  					 fifth_1(mapFolderId,access_token); 
  				  }
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   	};
   	  
     }
     
      async function fifth_1(file,access_token){
    	 var folders = [ "주간업무보고","주간회의록","프로젝트 업무보고","회의록(자유양식)","회의록(회의비 포함)","일반행사계획서"];
    	 var index = 0;
    	 for(const element of folders){
   		  request = gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file.get("보고"),
  					}]
  			   }
  			}); 
  		 await request.execute(function(resp) {
  			 index++
  			 if (!resp.error) {
  				 folderMap.set(element,resp.id)
  				  console.log("level5-1 success");
  				 
  				  if(index == 6){
  				 fifth_1_1(file,access_token);
  				  }
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   	}
   	  
     }
      async function fifth_1_1(file,access_token){
     	 var folders = ["대외공문","월간업무보고","월간회의록","일반기안서","일반품의서","일일업무보고"];
     	 var index = 0;
     	 for(const element of folders){
    		  request = gapi.client.request({
   			   'path': '/drive/v2/files/',
   			   'method': 'POST',
   			   'headers': {
   				   'Content-Type': 'application/json',
   				   'Authorization': 'Bearer ' + access_token,             
   			   },
   			   'body':{
   				   "title" : element,
   				   "mimeType" : "application/vnd.google-apps.folder",
   				   "parents": [{
   						"kind": "drive#file",
   						"id": file.get("보고"),
   					}]
   			   }
   			}); 
   		 await request.execute(function(resp) {
   			 index++
   			 if (!resp.error) {
   				folderMap.set(element,resp.id);
   				  console.log("level5-1 success");
   				 
   				  if(index == 6){
   				 fifth_2(file,access_token);
   				  }
   			  }else{
   				  console.log("Error: " + resp.error.message);
   			  }
   		  });
    	}
    	  
      }
      async function fifth_2(file,access_token){
   
   		  request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : '품질보고서',
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file.get("업무"),
  					}]
  			   }
  			}); 
   		await request.execute(function(resp) {
  			  if (!resp.error) {
  				  console.log("level5-2 success");
  				folderMap.set("품질보고서",resp.id);
  				fifth_3(file,access_token); 
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  	
   			})
   	  
     }
      async function fifth_3(file,access_token){
    	 var folders = ["결근사유서","교육신청서","병가신청서","복직신청서","사직신청서","외근신청서"];
    	 var index = 0;
    	 for(const element of folders){
    		 
   		  request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file.get("인사"),
  					}]
  			   }
  			}); 
   		await request.execute(function(resp) {
  			  index++
  			  if (!resp.error) {
  				  console.log("level5-3 success");
  				folderMap.set(element,resp.id);
  				  if(index ==6){
  				fifth_3_1(file,access_token); 
  		
  				  }
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   	}
   	  
     }
      async function fifth_3_1(file,access_token){
     	 var folders = ["조퇴신청서","채용계획서","출장신청서","퇴직신청서","휴가신청서","휴직신청서","면접평가서"];
     	 var index = 0;
     	 for(const element of folders){
     		 
    		  request =gapi.client.request({
   			   'path': '/drive/v2/files/',
   			   'method': 'POST',
   			   'headers': {
   				   'Content-Type': 'application/json',
   				   'Authorization': 'Bearer ' + access_token,             
   			   },
   			   'body':{
   				   "title" : element,
   				   "mimeType" : "application/vnd.google-apps.folder",
   				   "parents": [{
   						"kind": "drive#file",
   						"id": file.get("인사"),
   					}]
   			   }
   			}); 
    		await request.execute(function(resp) {
   			  index++
   			  if (!resp.error) {
   				  console.log("level5-3 success");
   				folderMap.set(element,resp.id);
   				  if(index ==7){
   				fifth_4(file,access_token); 
   				  }
   			  }else{
   				  console.log("Error: " + resp.error.message);
   			  }
   		  });
    	}
    	  
      }
      async function fifth_4(file,access_token){
    	 var folders = ["경조비지급신청서","교통비지출신청서","부서지출결의서","외근비지출신청서","접대비지출신청서","지출결의서",
    		 "출장비지출신청서","프로젝트 지출결의서","회식비 지출신청서"];
    	 var index =0;
    	 for(const element of folders){
    	
   		  request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file.get("재무"),
  					}]
  			   }
  			}); 
   		await request.execute(function(resp) {
  			  index++
  			  if (!resp.error) {
  				  console.log("level5-4 success");
  				folderMap.set(element,resp.id);
  				  if(index == 9){
  				fifth_5(file,access_token);
  				  }
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   		}
   	  
     }
      async function fifth_5(file,access_token){
    	 var folders = ["구매요청서","명함신청서"];
    	 var index = 0;
    	 for(const element of folders){
    		
   		  request =gapi.client.request({
  			   'path': '/drive/v2/files/',
  			   'method': 'POST',
  			   'headers': {
  				   'Content-Type': 'application/json',
  				   'Authorization': 'Bearer ' + access_token,             
  			   },
  			   'body':{
  				   "title" : element,
  				   "mimeType" : "application/vnd.google-apps.folder",
  				   "parents": [{
  						"kind": "drive#file",
  						"id": file.get("총무"),
  					}]
  			   }
  			}); 
   		await  request.execute(function(resp) {

  			  if (!resp.error) {
  				  console.log("level5-5 success");
  				folderMap.set(element,resp.id);
				  
  			  }else{
  				  console.log("Error: " + resp.error.message);
  			  }
  		  });
   	}
    	 finallyfunction();
     }
       
      //페이지 넘어가는 메서드
      
      function finallyfunction(){
    	  
    	 folderMap.set("url",company);
    	
 		var jsonObject = folderMap.keys();
    	 for (var [key, value] of folderMap.entries()){
    		jsonObject[key] = value;  
    	 }
    	 

    	
    	   $.ajax({ //folder 주소와 이름 값들을 서버에 가져다주는 ajax
 			url : "insertFolders.do",
 			type : "post",
 			contentType : "application/json; charset=utf-8",
 			data : JSON.stringify(jsonObject),
 			success : function(result) { 
 			
 				if(result != "" || result.length > 0){
 					location.href='company?url='+result;					
 				}else{
 					 companyResit(login_info);
 				}
 			},
 			beforeSend : function() {
 				$('.wrap-loading').removeClass('display-none');
 			},
 			complete : function() {
 				$('.wrap-loading').addClass('display-none');
 			},
 			error : function(request, status, errorData) {
 				console.log("error code : " + request.status + "\n"
 						+ "message : " + request.responseText + "\n"
 						+ "error : " + errorData);
 			},
 			timeout : 100000
 		});	 
    	  
    	  location.replace('company?url='+company);	 
      };
      
      /**
       *  Sign in the user upon button click.
       */
      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }

      /**
       *  Sign out the user upon button click.
       */
      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node. Used to display the results of the API call.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
        
      }

      /**
       * Print files.
       */
       
      function listFiles() {
        gapi.client.drive.files.list({
          'pageSize': 15,
          'fields': "nextPageToken, files(id, name,parents)"
        }).then(function(response) {
          appendPre('Files:');
          var files = response.result.files;
          if (files && files.length > 0) {
            for (var i = 0; i < files.length; i++) {
               if(i == 0){
                  parentId = files[0].parents;
               }
              var file = files[i];
              $("#content").append('<a href ="https://docs.google.com/spreadsheets/d/'+file.id+'/edit#gid=0">'+file.name +' (' + file.id + ')'+file.parents+'</a><br>');
            }
          } else {
            appendPre('No files found.');
          }
        });
      }

      function makeApiCall() {
          var fileMetadata = {
        		  'parents' : '1_4qCvD1GnvgzSg1JUraiSYERQBDPf9M8'         
                  };
                  gapi.client.drive.files.copy({
                    resource: fileMetadata,
                    "fileId": "15UZkRmQ1xKZ6fBEWC4LR1RN8jpjUiFZoFNiXP69_NKM",
                   	"name" : "복사된 품질이상 보고서!"
                  }).then(function(response) {
                    switch(response.status){
                      case 200:
                        var file = response.result;
                        console.log('Created spread Id: ', file.id);
                        break;
                      default:
                        console.log('Error creating the folder, '+response);
                        break;
                      }
                  }); 
        }
    </script>

<body>
<div class="wrap-loading display-none" id="loading" style="display: none;">

	<div>
		<img class="loadingimage" src="https://ubisafe.org/images/gif-transparent-adventure-time-5.gif" />
	</div>

</div>
	<div class="g-signin2" data-onsuccess="onSignIn"></div>
	<button onclick="createFolder()">new Folder</button>
	<button onclick="makeApiCall()">new sheet</button>
	<pre id="content"></pre>
</body>
<script async defer src="https://apis.google.com/js/api.js"
	onload="this.onload=function(){};handleClientLoad()"
	onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
</html>