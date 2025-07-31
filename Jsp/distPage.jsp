	pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<script src="${contextPath}/assets/appJs/validation/common-utils.js"></script>
<div class="content">
	<div class="panel-header bg-primary-gradient">
		<div class="page-inner py-4">
			<div
				class="d-flex align-items-left align-items-md-center flex-column flex-md-row">
				<div>
					<h2 class="text-blue pb-2 fw-bold">Add Distict</h2>
				</div>
				<div class="ml-md-auto mb-4 py-2 py-md-0">
					<a href="${contextPath}"
						class="btn btn-sm btn-border btn-blue btn-round mr-2"><i
						class="fa fa-home"></i></a> <a href="${contextPath}"
						class="btn btn-sm btn-border btn-blue btn-round mr-2">Add
						Postal</a>
				</div>
			</div>
		</div>
	</div>
	<div class="page-inner mt--5 pb-0">
		<%@ include file="/WEB-INF/views/message.jsp"%>
		<div class="row mt-3">
			<div class="col-md-12">
				<div class="card full-height">
					<div class="card-header">
						<div class="panel-actions">
							<a href="#" class="fa fa-caret-down"></a>
						</div>
						<h4 class="card-title">Add Distict</h4>
					</div>
					<div class="card-body" style="">
							<form action="/dist/add-dist" id="submitForm" method="post" enctype="multipart/form-data">
								
								
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
	
					
							<c:if test="${not empty oneState}">
    								<input type="hidden" value="" class="form-control form-control-sm"
        									id="stateid" name="stateid">
							</c:if>

<div class="col-md-3">
    <div class="form-group">
        <label class="col-md-12 smallInput required" for="stateSelect">State Name :</label>
        <div class="col-md-12">
            <select class="form-control form-control-sm" id="stateSelect" name="stateSelect" required>
                <option value="">-- Select State --</option>
                <c:forEach var="state" items="${states}">
                    <option value="${state.stateid}">${state.stateName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
</div>

					
								<div class="col-md-3">
									<div class="form-group">
										<label class="col-md-12 smallInput required" for="name">Distict
											Name :</label>
										<div class="col-md-12">
											<input type="text" value="" class="form-control form-control-sm	"
												id="distName" name="distName">
										</div>
									</div>
								</div>
	

 							    <div class="col-md-3">
							        <div class="form-group">
							            <label class="col-md-12 smallInput required" for="age">DistictCode :</label>
							            <div class="col-md-12">
							                <input type="text" class="form-control form-control-sm" value="" id="distCode" name="distCode" readonly>
							            </div>
							        </div>
							    </div>
							

	  							
								<div class="col-md-12 text-center mt-3">
    								<div class="form-group">
<!--         								<input type="submit" class="btn btn-success btn-sm me-2" value="Submit" />
 -->   								
								
								
								<c:choose>
    								<c:when test="${not empty oneState}">
        								<input type="submit" class="btn btn-success btn-sm me-2" value="Update" />
    								</c:when>
    							<c:otherwise>
        							<input type="submit" class="btn btn-success btn-sm me-2" value="Save" />
    							</c:otherwise>
							</c:choose>
								</div>
								</div>
							</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- <br> -->
<%-- <div class="card-body" style="display:${sectionHead}">
	<div class="col-md-12">
		<table class="table DataTable table-bordered">
			<thead>
				<tr>
					<th>Sl No.</th>
					<th>State Name</th>
					<th>Dist Name</th>
					<th>Dist Code</th>
					<th>Edit</th>
					<th>Lock</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${states}" var="state" varStatus="loop">
					<tr>
						<td>${loop.count}</td>
						<td>${state.stateName}</td>
						<td>${state.stateCode}</td>
						<td>
							<a href="${contextPath}/state/editState/${state.stateid}" 
   										class="btn btn-success btn-xs" 
   										data-toggle="tooltip" title="edit">
								<i class="fas fa-pencil-alt"></i>
							</button>
						</td>
	
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
 --%>


<script>
$(document).ready(function () {

    // Clear distCode when user types
    $('#distName').on('input', function () {
        $('#distCode').val('');
    });

    // When the input loses focus, generate the code
    $('#distName').on('blur', function () {
        var distName = $('#distName').val().trim();

        if (distName !== '') {
            $.ajax({
                url: '${contextPath}/dist/generateDistCode',
                type: 'GET',
                data: { distName: distName },
                success: function (response) {
                    $('#distCode').val(response);
                },
                error: function () {
                    bootbox.alert("Failed to generate district code");
                }
            });
        }
    });
});



</script>


