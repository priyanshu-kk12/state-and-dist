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
					<h2 class="text-blue pb-2 fw-bold">Add State</h2>
				</div>
				<div class="ml-md-auto mb-4 py-2 py-md-0">
					<a href="${contextPath}/dist/home"
						class="btn btn-sm btn-border btn-blue btn-round mr-2"><i
						class="fa fa-home"></i></a> <a href="${contextPath}/dist/home"
						class="btn btn-sm btn-border btn-blue btn-round mr-2">Add District</a>
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
						<h4 class="card-title">Add State</h4>
					</div>
					<div class="card-body" style="">
							<form action="/state/saveData" id="submitForm" method="post" enctype="multipart/form-data">
								
								
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" />
	
					
							<c:if test="${not empty oneState}">
    								<input type="hidden" value="${oneState.stateid}" class="form-control form-control-sm"
        									id="stateid" name="stateid">
							</c:if>

					
					
	
								<div class="col-md-3">
									<div class="form-group">
										<label class="col-md-12 smallInput required" for="name">State
											Name :</label>
										<div class="col-md-12">
											<input type="text" value="${oneState.stateName }" class="form-control form-control-sm	"
												id="stateName" name="stateName">
										</div>
									</div>
								</div>
	

 							    <div class="col-md-3">
							        <div class="form-group">
							            <label class="col-md-12 smallInput required" for="age">stateCode :</label>
							            <div class="col-md-12">
							                <input type="text" class="form-control form-control-sm" value="${oneState.stateCode }" id="stateCode" name="stateCode" readonly>
							            </div>
							        </div>
							    </div>
							
	
						<!-- 		<div class="row">
  									<div class="col-12 d-flex justify-content-end mb-3">
    									<a href="/distPage" class="btn btn-danger btn-sm">Add District</a>
  									</div>
								</div> -->

	 
	
	 							
	
	  							
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
<div class="card-body" style="display:${sectionHead}">
	<div class="col-md-12">
		<table class="table DataTable table-bordered">
			<thead>
				<tr>
					<th>Sl No.</th>
					<th>Name</th>
					<th>Code</th>
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
						<td>
							<%-- <c:choose>
    <c:when test="${state.isActive}">
        <!-- Unlocked / Green -->
        <a href="${contextPath}/state/lockState/${state.stateid}"
           class="btn btn-success btn-xs"
           data-toggle="tooltip" title="Click to Lock">
            <i class="fas fa-lock-open"></i>
        </a>
    </c:when>
    <c:otherwise>
        <!-- Locked / Red -->
        <a href="${contextPath}/state/lockState/${state.stateid}"
           class="btn btn-danger btn-xs"
           data-toggle="tooltip" title="Click to Unlock">
            <i class="fas fa-lock"></i>
        </a>
    </c:otherwise>
</c:choose>
 --%>

<a href="javascript:void(0);"
   class="btn ${state.isActive ? 'btn-success' : 'btn-danger'} btn-xs toggle-lock"
   data-id="${state.stateid}"
   data-toggle="tooltip"
   title="${state.isActive ? 'Click to Lock' : 'Click to Unlock'}">
    <i class="fas ${state.isActive ? 'fa-lock-open' : 'fa-lock'}"></i>
</a>

						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>



<script>
$(document).ready(function () {

    $('#stateName').on('input', function () {
        $('#stateCode').val('');
    });

    $(document).on('click', function (e) {
        if (!$(e.target).is('#stateName')) {
            var stateName = $('#stateName').val().trim();
            var stateCode = $('#stateCode').val().trim();

            if (stateName !== '' && stateCode === '') {
                // First check if state already exists
                $.ajax({
                    url: '${contextPath}/state/checkIfExists',
                    type: 'GET',
                    data: { stateName: stateName },
                    success: function (exists) {
                        if (exists === true) {
                            bootbox.alert("State already exists!");
                        } else {
                            // If not exists, generate the code
                            $.ajax({
                                url: '${contextPath}/state/generateStateCode',
                                type: 'GET',
                                data: { stateName: stateName },
                                success: function (response) {
                                    $('#stateCode').val(response);
                                },
                                error: function () {
                                    bootbox.alert("Failed to generate state code");
                                }
                            });
                        }
                    },
                    error: function () {
                        bootbox.alert("Failed to check state existence.");
                    }
                });
            }
        }
    });
});


$(document).ready(function () {
	  $('.toggle-lock').on('click', function () {
	    var btn = $(this);
	    var icon = btn.find('i');
	    var stateId = btn.data('id');

	    $.ajax({
	      url: '/state/lockState/' + stateId,
	      method: 'GET',
	      success: function (response) {
	        if (response === 'active') {
	          // Set to unlocked (green)
	          btn.removeClass('btn-danger').addClass('btn-success');
	          icon.removeClass('fa-lock').addClass('fa-lock-open');
	          btn.attr('title', 'Click to Lock');

	          bootbox.alert('State has been <strong>Unlocked</strong> successfully.', function () {
	            location.reload();
	          });

	        } else {
	          // Set to locked (red)
	          btn.removeClass('btn-success').addClass('btn-danger');
	          icon.removeClass('fa-lock-open').addClass('fa-lock');
	          btn.attr('title', 'Click to Unlock');

	          bootbox.alert('State has been <strong>Locked</strong> successfully.', function () {
	            location.reload();
	          });
	        }

	        // Refresh tooltip
	        btn.tooltip('hide')
	           .attr('data-original-title', btn.attr('title'))
	           .tooltip('show');
	      },
	      error: function () {
	        bootbox.alert('Something went wrong while updating status.');
	      }
	    });
	  });
	});


</script>


