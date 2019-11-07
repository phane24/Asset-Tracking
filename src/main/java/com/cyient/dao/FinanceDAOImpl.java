package com.cyient.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.jboss.logging.Logger;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import com.cyient.model.AssetInstallation;
import com.cyient.model.AssetStock;
import com.cyient.model.DeliveryChallan;
import com.cyient.model.Device;
import com.cyient.model.EquipInstallation;
import com.cyient.model.EquipStock;
import com.cyient.model.Indent;
import com.cyient.model.IndentApproval;
import com.cyient.model.IndentData;
import com.cyient.model.IndentTracker;
import com.cyient.model.InstallationTracker;
import com.cyient.model.Item;
import com.cyient.model.ItemTracker;
import com.cyient.model.OrderAcknowledgement;
import com.cyient.model.PurchaseOrder;
import com.cyient.model.PurchaseOrderAssets;
import com.cyient.model.PurchaseOrderEquips;
import com.cyient.model.PurchaseRequest;
import com.cyient.model.Site;
import com.cyient.model.Store_Details;
import com.cyient.model.User;
import com.cyient.model.VendorReg;
import com.cyient.model.VendorSupplier;
import com.cyient.model.waerhouseDeliveryChallan;

import javassist.compiler.NoFieldException;


@SuppressWarnings("unused")
@Repository
//@Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
public class FinanceDAOImpl implements FinanceDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public List<Indent> getAllIndents() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from Indent").list();
	}

	@Override
	public List<IndentApproval> fetchApprovalsList() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from IndentApproval where status='Approved'").list();
	}

	@Override
	public List<IndentApproval> fetchDetailApprovedIndent(String id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from InstallationTracker where itemType='"+id+"'" ).list();
	}

	@Override
	public List<IndentApproval> fetchRejectedList() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from IndentApproval where status='Rejected'").list();
	}

	@Override
	public String saveVendor(VendorSupplier vendor) {
		
			return "Failure";
		
	}

}
