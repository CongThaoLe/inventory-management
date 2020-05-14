package inventory.dao;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.cj.xdevapi.SessionFactory;

import inventory.model.ProductInfo;

@Repository
@Transactional(rollbackFor = Exception.class)
@Scope(proxyMode=ScopedProxyMode.TARGET_CLASS)
public class ProductInfoDAOImpl extends BaseDAOImpl<ProductInfo> implements ProductInfoDAO<ProductInfo> {
	@Autowired
	private org.hibernate.SessionFactory sessionFactory;
	public ProductInfo getProductInfoWithID(int id) {
		Session session = sessionFactory.getCurrentSession();
		String sql = "from ProductInfo where id = "+id;
		return (ProductInfo) session.createQuery(sql).getSingleResult();
	}

}
