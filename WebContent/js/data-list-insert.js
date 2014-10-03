/**
 * Script for operating data by the Admin
 */

$(document).ready(function() {
	$("#add-data").click(function() {
		$(this).hide();
		$("#y-o-n").show();
	}).hover(function() {
		$(this).css("background", "#ece8e8");
	}, function() {
		$(this).css("background", "#d3d3d3");
	});
	$("#y-o-n #confirm").hover(function() {
		$(this).css("background", "#a2f3a2");
	}, function() {
		$(this).css("background", "#fff");
	});
	$("#y-o-n #cancel").click(function() {
		$("#content-list tr:last").remove();
		$("#add-data").show();
		$("#y-o-n").hide();
	}).hover(function() {
		$(this).css("background", "#fa7288");
	}, function() {
		$(this).css("background", "#fff");
	});
});

function createNewInput(newInput) {
	$("#content-list").append(newInput);
}

function insertData(entityName, jsonDataAttr) {
	$.ajax( {
		url: "insert/" + entityName,
		type: "POST",
		dataType: "JSON",
		data: {
			jsonDataAttr: jsonDataAttr
		}
	}).done(function( json ) {
		$("#content-list tr:last").remove();
		$("#add-data").show();
		$("#y-o-n").hide();
		var lastId = parseInt($("#content-list tr:last td:first").html());
		if (json.maxId > lastId || json.maxId == 1)
			showNewData(json.maxId, entityName);
		else
			alert("数据未能插入成功");
	}).fail(function() {
		alert("FAIL");
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		$("body").append(XMLHttpRequest.responseText);
	});
}

function showNewData(columnId, entityName) {
	$.ajax( {
		url: "../ajax/fetchEntityJSONDataById",
		type: "POST",
		dataType: "JSON",
		data: {
			id: columnId,
			entityName: entityName
		}
	}).done(function( json ) {
		var newData = "<tr>";
		$.each(json.data, function(i) {
			newData += "<td>" + json.data[i] + "</td>";
		});
		newData += "</tr>";
		$("#content-list").append(newData);
	}).fail(function() {
		alert("FAIL");
	}).error(function (XMLHttpRequest, textStatus, errorThrown) {
		$("body").append(XMLHttpRequest.responseText);
	});
}