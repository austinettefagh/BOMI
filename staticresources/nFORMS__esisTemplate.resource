<!DOCTYPE html>
<html>

<body>
	<!-- Header Image source has to be from staticresources or contentversion url -->
	<!-- <p><img id="fixed_header" style="position: fixed; top: 0px; width: 20%; left: 40%;"
			src="STATIC_RESOURCES_IMAGE_URL_HERE" /></p> -->
	<p
		id="fixed_footer"
		style="position: fixed; bottom: 0px; width: 50%; left: 25%; text-align: center; font-size: 10px;"
	>nSIGHT
		Financial<br />25 High Street London, SE1 1PU</p>

	<p> </p>
	<h1
		id="opening_page"
		style="font-size: 60px; text-align: center; margin-top: 450px;"
	>
		nSIGHT Financial
	</h1>
	<h2 style="text-align: center;">Generated Documents</h2>

	<p>
	<div class="mce-pagebreak"></div>
	</p>
	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td
					style="background-color: #aeb6bf;"
					colspan="2"
				><strong>1. Lender</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td style="vertical-align: top;">Lender:</td>
				<td style="vertical-align: top;">nSight Financial</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">Phone Number:</td>
				<td style="vertical-align: top;">0800 123 1234</td>
			</tr>
			<tr>
				<td style="vertical-align: top;">Address:</td>
				<td style="vertical-align: top;">25 High Street <br>London<br>SE1 1PU</td>
			</tr>
		</tbody>
	</table>


	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>2. Main features of the loan</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr style="padding: 10px;">
				<td>
					<p>Amount and currency of the loan to be granted: £{{FIELD="LLC_BI__Loan__c.LLC_BI__Amount__c"}}</p>

					<p>Duration of the loan: {{FIELD="LLC_BI__Loan__c.LLC_BI__Term_Months__c"}} months.
						<br>This is a repayment loan of £{{FIELD="LLC_BI__Loan__c.LLC_BI__Amount__c"}} on a fixed rate that
						will
						apply from completion until 10/02/2023
					</p>

					<p>After 10/02/2023 the rate that will apply is a variable rate, which varies in accordance with changes
						to
						the Bank of England Rate. The variable rate will not go below a floor for the remaining term.</p>

					<p>The Bank of England Base Rate is a variable rate set by the Bank of England. For further information
						please
						visit
						<a href="http://www.bankofengland.co.uk">www.bankofengland.co.uk</a>
					</p>

					<p>Total amount to be repaid:
						£{{FIELD="LLC_BI__Loan__c.LLC_BI__Total_Debts__c”}}.<br>This amount is illustrative and may vary, in
						particular in relation with the variation of the borrowing rate.<br>This means you will pay back £1.06
						for
						every £1 borrowed.</p>

					<p>The purchase price of the property assumed to prepare this Offer:
						£{{LIST="LLC_BI__Mortgage__c"}}{{FIELD="LLC_BI__Mortgage__c.LLC_BI__Purchase_Price_2__c"}}{{ENDLIST}}.<br>Maximum
						available loan amount relative to the value of the property:
						{{FIELD="LLC_BI__Loan__c.LLC_BI__Current_LTV__c”}}%.<br>The maximum theoretically possible to borrow
						would
						be £{{FIELD="LLC_BI__Loan__c.LLC_BI__Current_Total_Lendable_Value__c”}}</p>

					<p>This loan is secured on your home.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>3. Interest rate and other costs</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr style="padding: 10px;">
				<td>
					<p>The annual percentage rate of charge (APRC) is the total cost of the loan expressed as an annual
						percentage. The APRC is provided to help you compare different offers.</p>

					<p>The APRC applicable to your loan is {{FIELD="LLC_BI__Loan__c.LLC_BI__APR__c"}}</p>

					<p>It comprises: <br>
						<strong>Interest rate(s)</strong>
					</p>
					<p>
					<dl>
						<dt>Step 1:</dt>
						<dd>A loan of £{{FIELD="LLC_BI__Loan__c.LLC_BI__Amount__c"}} on a fixed rate of
							3.5% that will apply from completion until 10/02/2023</dd>
						<dt>Step 2:</dt>
						<dd>After 10/02/2023 the rate that will
							apply is a variable rate, which is 2.5% above the Bank of England Base rate, currently 0.25%, to
							give a
							current rate payable of 2.75%. The variable rate will not go below a floor of 0% for the remaining
							term.</dd>
					</dl>
					</p>
					<p><strong>Costs to be paid on a one-off basis: </strong></p>
					<table
						style="width: 100%; border-collapse: collapse; border-spacing: 0px;"
						border="0"
					>
						<tbody>
							<tr>
								<td style="background-color: #aeb6bf;"><strong>Fees payable to nSight</strong></td>
								<td style="background-color: #aeb6bf;"><strong>Fee amount</strong></td>
							</tr>
							<tr>
								<td>{{LIST="LLC_BI__Fee__c"}}{{FIELD="LLC_BI__Fee__c.LLC_BI__Fee_Type__c"}}
								</td>
								<td>£ {{FIELD="LLC_BI__Fee__c.LLC_BI__Amount__c"}}{{ENDLIST}}</td>
							</tr>
						</tbody>
					</table>

					<p><strong>Costs to be repaid regularly: </strong><br>
						None</p>
					<p>This APRC is calculated using assumptions regarding the interest rate.</p>

					<p><strong>Because part of your loan is a variable interest
							rate loan, the actual APRC could be different from this APRC if the interest rate for your loan
							changes.
							For example, if the interest rate rose to 9.49%, the APRC could increase to 10.00%</strong></p>

					<p>The following costs are not known to the lender and are therefore not included in the APRC: <br>
						Legal fee, Land Registry fee</p>

					<p>Please make sure that you are aware of all other taxes and costs associated
						with your loan.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td
					style="background-color: #aeb6bf;"
					colspan="2"
				><strong>4. Frequency and number of
						payments</strong><strong><br></strong>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Repayment frequency: </td>
				<td>Monthly</td>
			</tr>
			<tr>
				<td>Number of payments: </td>
				<td>{{FIELD="LLC_BI__Loan__c.LLC_BI__Term_Months__c"}}</td>
			</tr>
		</tbody>
	</table>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td
					style="background-color: #aeb6bf;"
					colspan="2"
				><strong>5. Amount of each installment</strong></td>
			</tr>
		</thead>
		<tbody style="padding: 10px;">
			<tr>
				<td colspan="2">
					<p>These payments are based on a loan amount £{{FIELD="LLC_BI__Loan__c.LLC_BI__Amount__c"}} of and
						include the
						fees that are shown in the interest rate and other costs section as being added to your mortgage and
						assume
						the mortgage will start on {{FIELD="LLC_BI__Loan__c.LLC_BI__First_Payment_Date__c"}}. Your first
						payment
						will
						include interest due from the date of completion to the end of that month which will be added to your
						normal
						monthly payment in the following month.</p>
				</td>
			</tr>
			<tr>
				<td>3.5%</td>
				<td>£842.70</td>
			</tr>
			<tr>
				<td
					style="text-align: center;"
					colspan="2"
				>
					<p>Followed by</p>
				</td>
			</tr>
			<tr>
				<td>2.75%</td>
				<td>£795.20</td>
			</tr>
			<tr>
				<td colspan="2">
					<p>Your income may change. Please consider whether you will still be able to afford your
						monthly repayment
						instalments if your income falls.</p>
					<p>The interest rate on part of this loan can change. This means the
						amount of your monthly payments could increase or decrease. For example, if the interest rate rose to
						9.49%,
						your payments could increase to.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>6. Additional obligations</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>The borrower must comply with the following obligations in order to benefit from the lending
						conditions
						described in this document.</p>
					<p><strong>Building Insurance</strong><br>You must take out buildings
						insurance as a condition of your mortgage but you do not have to take out this insurance through
						nSight.
						Please ensure that buildings insurance on your property is in place and you have adequate cover.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>7. Early repayment</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>You have the possibility to repay this loan early, either fully or partially.</p>
					<p>The figures assume
						a start date for the mortgage of {{FIELD="LLC_BI__Loan__c.LLC_BI__First_Payment_Date__c"}}<br>Early
						repayment charges are payable on this mortgage until 10/02/2023 as follows.</p>
					<p>Loan amount -
						£{{FIELD="LLC_BI__Loan__c.LLC_BI__Amount__c"}} <br>Basis of the charge - 2.00% <br>Date of repayment -
						until 10/02/2023<br>Maximum amount of - £8,519.98</p>
					<p>Any early repayment charges are for
						illustration only.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>8. Flexible features</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p><strong><u>Portability</u></strong><br>You have the right to transfer the outstanding balance of this
						Loan to another property, subject to the new property and your circumstances meeting our lending
						criteria at
						that time. Other fees may be charged when porting the mortgage interest rate and the terms and
						conditions
						for the new mortgage agreement will also apply.
					</p>
					<p>You do not have the right to transfer this loan to another lender.</p>
					<p><u><strong>Additional Features</strong></u><br><strong>Overpayments</strong><br>
						A capital reduction of 10% per annum can be made without incurring an early repayment charge. This
						will
						apply throughout the early repayment charge period. Please refer to the early repayment section for
						details.</p>
					<p>Following receipt of an overpayment, we will immediately reduce the mortgage balance on
						which interest is charged and recalculate the amount that you owe. This means that you will get the
						benefit
						straight away.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>9. Other rights of the borrower</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>You have 7 days after the date of the offer to reflect before
						committing yourself to taking out this loan.</p>
					<p>You have the right to transfer the outstanding balance of
						this Loan to another property, subject to the new property and your circumstances meeting our lending
						criteria at that time.</p>
					<p>A Mortgage Exit fee will be payable and an early repayment charge may be payable in respect
						of the mortgage that is being redeemed.</p>
					<p>Other fees may be charged when porting the mortgage interest
						rate and the terms and conditions for the new mortgage agreement will also apply.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>10. Complaints</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><br>If you have a complaint, please contact:<br><br>
					<table
						style="width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
						border="0"
					>
						<tbody>
							<tr>
								<td style="text-align: right; vertical-align: top;">
									In writing:
								</td>
								<td style="text-align: left; vertical-align: top;">
									nSight Financial<br>25 High Street<br>London<br>SE1 1PU
								</td>
							</tr>
							<tr>
								<td style="text-align: right; vertical-align: top;">
									By phone:
								</td>
								<td style="text-align: left; vertical-align: top;">
									0800 123 1234
								</td>
							</tr>
						</tbody>
					</table>
					<p>For further information on our complaints process please visit <a
							href="http://www.barclays.co.uk/help/making-a-complaint/how-do-i-make-a-complaint-/"
						>www.nsight.co.uk/help/making-a-complaint/how-do-i-make-a-complaint-/</a>
					</p>
					<p>Maximum time for handling
						the complaint: 8 weeks.</p>
					<p>If we do not resolve the complaint to your satisfaction internally, you can also
						contact the Financial Ombudsman Service: <a
							href="http://www.financial-ombudsman.org.uk">www.financial-ombudsman.org.uk</a></p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>11. Non-compliance with the commitments linked to the loan:
						consequences for the borrower</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>If you do not take out and maintain insurance for the property nSight may instead take out similar
						insurance cover and you will have to pay for this.</p>
					<p>If you fail to adequately maintain the property, or
						if you take actions that negatively affect the property's value nSight has the right to take remedial
						steps
						and to recover these costs from you.</p>
					<p>If you do not make payments relating to your property on
						time nSight may make such payments on your behalf and will add the cost of these payments to your
						loan.
						Examples of such payments are service charges, ground rent and estate rent charges.</p>
					<p>We will
						provide you with a booklet of terms and conditions relating to this mortgage. This will provide
						further
						information on your obligations under the contract.</p>
					<p>
						Should you encounter difficulties in making your monthly payments, please contact us straight away to
						explore
						possible solutions. </p>
					<p><strong>As a last resort, your home may be repossessed if you do not keep up
							with payments. </strong></p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>12. Additional information</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>This loan will be governed by the laws of the country where your property is located.
					</p>
					<p>You
						are not bound by the terms of this Offer document until the funds are released on your
						mortgage.</p>
					<p>You should compare this Offer document with the information sheet given to you before
						you applied for this mortgage, to see how the details may have changed.</p>
				</td>
			</tr>
		</tbody>
	</table>


	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<thead>
			<tr>
				<td style="background-color: #aeb6bf;"><strong>13. Supervisor</strong></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<p>This lender is supervised by the Financial Conduct Authority, www.fca.org.uk.</p>
					<p>This credit
						intermediary is supervised by the Financial Conduct Authority, www.fca.org.uk.</p>
				</td>
			</tr>
		</tbody>
	</table>

	<p>
	<div class="mce-pagebreak"></div>
	</p>

	<table
		style="margin-top: 90px; width: 100%; border-collapse: collapse; border-spacing: 0px; border-style: solid;"
		border="3"
	>
		<tbody>
			<tr>
				<td style="padding: 10px;"><strong>Supplementary conditions:<br></strong>
					<div style="font-size: 9px;">
						<p>Lorem
							ipsum dolor sit amet, consectetur adipiscing elit. Etiam quis sapien ipsum. Nam mollis tempus
							lacinia.
							Suspendisse posuere vestibulum orci, ac suscipit est laoreet eu. Morbi neque neque, viverra sed
							cursus sit
							amet, pulvinar sed libero. Sed ut molestie metus, vel imperdiet quam. Duis commodo, dolor eu
							eleifend
							aliquam,
							velit diam auctor quam, a facilisis libero nunc at neque. Maecenas egestas laoreet odio, ac
							hendrerit
							purus.
							Aliquam placerat vel ante vel ultrices. Nullam maximus aliquet placerat. Aenean aliquet fringilla
							nunc ac
							iaculis. Cras suscipit urna nec egestas elementum. Vestibulum pharetra gravida sapien at ultricies.
							Ut
							lectus
							felis, sodales a iaculis non, feugiat in turpis.</p>
						<p>Suspendisse potenti. Nulla feugiat imperdiet
							lectus, non dignissim urna volutpat sit amet. Cras quis magna nibh. Maecenas gravida est ac mauris
							mollis
							consequat. Sed a nisl at arcu pretium sollicitudin id nec tortor. Pellentesque sollicitudin sem ut
							ipsum
							vehicula congue. Proin facilisis nulla vitae suscipit semper. Donec rhoncus viverra sollicitudin.
							Pellentesque
							habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
						<p>Mauris
							consectetur
							sapien in ante sollicitudin blandit. Quisque nec elementum enim. Fusce sit amet viverra elit.
							Nullam
							iaculis,
							velit id blandit dictum, erat neque tincidunt enim, nec tempor augue libero ac dui. Ut vel dolor
							dui.
							Vivamus
							in nibh dui. Donec at fermentum neque, quis dictum ex. Integer efficitur eleifend arcu ac
							scelerisque.
							Aenean
							eros urna, condimentum in faucibus quis, molestie non tellus. In maximus, ante et dictum efficitur,
							massa
							urna
							lobortis ante, in hendrerit est odio sed nisi. Nulla ultricies tortor lectus, id vestibulum ligula
							pulvinar
							ut. Sed odio mauris, rutrum eu tortor at, sagittis tincidunt ante. Proin ipsum leo, volutpat eu
							magna
							quis,
							blandit tristique justo.</p>
						<p>In in tortor sit amet risus lobortis ultrices. Donec aliquam tempus
							ullamcorper. Vivamus egestas urna id magna ultricies posuere. Proin scelerisque tristique lacus.
							Proin nec
							tempus eros. In consequat feugiat urna vel dignissim. Phasellus vel viverra purus.</p>
						<p>Cras porttitor
							dictum imperdiet. Sed sed tristique eros. Fusce tempus convallis lectus, non tempus sem congue sed.
							Suspendisse leo ante, sodales ultricies odio eu, dictum condimentum risus. Etiam quam lacus,
							interdum
							vitae
							porttitor ut, feugiat in ex. Vestibulum sed ipsum nec quam pellentesque pulvinar. Maecenas
							fermentum dolor
							eget elit faucibus, ut ornare arcu pulvinar. Curabitur placerat felis vel metus auctor dictum. Duis
							quam
							magna, auctor sit amet massa sit amet, lacinia accumsan risus. Quisque a dolor quam. Nulla in orci
							odio.
							Morbi
							at luctus est, sed lacinia ex. Morbi sed tortor nulla. Nam vitae blandit nisl, sed euismod turpis.
							Cras
							pulvinar erat quis orci efficitur viverra. Sed iaculis blandit scelerisque.</p>
						<p>In at iaculis ligula,
							sed blandit magna. Proin luctus ex vulputate viverra molestie. Phasellus ac tempor arcu, non
							malesuada
							dolor.
							Duis luctus hendrerit pretium. Suspendisse in odio ac enim viverra vulputate venenatis vel lacus.
							Aenean
							convallis facilisis lorem vitae vehicula. Ut consequat porta mattis. Sed facilisis varius congue.
							Ut non
							sapien placerat, sodales enim vitae, pharetra dui. Ut condimentum nisi nec magna malesuada, quis
							gravida
							tortor iaculis. Pellentesque lacinia quis nisl non blandit. Sed consectetur, metus in vulputate
							dapibus,
							neque
							lectus euismod massa, non molestie diam nunc porta arcu. Etiam finibus, orci non dignissim
							consectetur,
							massa
							augue efficitur est, et blandit mauris nibh posuere lorem. Quisque vitae mollis diam. Pellentesque
							vulputate
							lectus odio, non porttitor sem efficitur non. Nulla porta accumsan aliquam.</p>
						<p>Proin at porta
							ligula.
							Vivamus interdum tincidunt odio, vel vestibulum mauris tempor a. Orci varius natoque penatibus et
							magnis
							dis
							parturient montes, nascetur ridiculus mus. Phasellus feugiat mauris quis venenatis ultricies.
							Aenean eu
							maximus libero, sit amet malesuada est. Etiam dui dolor, cursus vel odio nec, ultricies ultricies
							est.
							Nunc
							lacinia, turpis sit amet pretium faucibus, risus massa pharetra orci, eget venenatis neque magna a
							enim.
							Curabitur tristique odio eu felis sagittis rhoncus. Praesent est erat, iaculis et cursus eu,
							finibus eget
							ex.
							Nam at lobortis orci, sit amet faucibus elit. Nulla consequat viverra aliquam. Ut vitae libero et
							turpis
							laoreet fermentum eu ac neque. Quisque elementum quam in ex ornare placerat. Proin sodales
							fringilla enim,
							nec
							pellentesque mi gravida faucibus. Aliquam posuere, enim vel volutpat sollicitudin, diam tellus
							accumsan
							ante,
							sit amet placerat sapien diam sit amet magna.</p>
						<p>Morbi a nisl magna. Ut ipsum dui, rutrum nec ante
							et,
							faucibus vulputate eros. Aenean ac nisl leo. Mauris nec rhoncus dolor. Quisque in ipsum facilisis,
							venenatis
							libero a, euismod turpis. Nunc ac rutrum purus. Donec non mi feugiat, molestie ligula quis,
							ultricies sem.
							Duis tincidunt luctus sapien et auctor. Maecenas porta aliquet felis congue viverra. Cras tellus
							lectus,
							varius a dictum id, placerat eu est.</p>
						<p>Cras convallis vitae velit non ornare. Vestibulum varius,
							ipsum ut finibus gravida, tellus nibh cursus quam, vel pretium libero orci quis libero. Aliquam vel
							ligula
							vitae tellus fermentum ullamcorper. Sed ante nulla, sollicitudin non arcu quis, efficitur lacinia
							nibh. In
							hac
							habitasse platea dictumst. Duis nulla mi, commodo ac molestie ut, tempor sit amet felis. Proin
							eleifend
							dolor
							gravida diam fringilla, tempor consectetur leo faucibus. Mauris vehicula tortor quis elit congue, a
							fermentum
							lectus congue.</p>
					</div>
				</td>
			</tr>
		</tbody>
	</table>

</body>

</html>
