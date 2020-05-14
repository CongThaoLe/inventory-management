package inventory.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import inventory.dao.ProductInStockDAO;
import inventory.model.Invoice;
import inventory.model.Paging;
import inventory.model.ProductInStock;
import inventory.model.ProductInfo;

@Service
public class ProductInStockService {
	@Autowired
	private ProductInStockDAO<ProductInStock> productInStockDAO;
	private static final Logger log = Logger.getLogger(ProductInStockService.class);
	
	public List<ProductInStock> getAll(ProductInStock productInStock,Paging paging){
		log.info("show all ProductInstock");
		StringBuilder queryStr = new StringBuilder();
		Map<String, Object> mapParams = new HashMap<String, Object>();
		if(productInStock!=null && productInStock.getProductInfo()!=null) {
			if(!StringUtils.isEmpty(productInStock.getProductInfo().getCategory().getName())) {
				queryStr.append(" and model.productInfo.category.name like :cateName");
				mapParams.put("cateName", "%"+productInStock.getProductInfo().getCategory().getName()+"%");
			}
			if(productInStock.getProductInfo().getCode()!=null && !StringUtils.isEmpty(productInStock.getProductInfo().getCode())) {
				queryStr.append(" and model.productInfo.code=:code");
				mapParams.put("code", productInStock.getProductInfo().getCode());
			}
			if(productInStock.getProductInfo().getName()!=null && !StringUtils.isEmpty(productInStock.getProductInfo().getName())){
				queryStr.append(" and model.productInfo.name like :name");
				mapParams.put("name", "%"+productInStock.getProductInfo().getName()+"%");
			}
		}
		return productInStockDAO.findAll(queryStr.toString(), mapParams, paging);
	}
	
	public void saveOrUpdate(Invoice invoice) {
		log.info("Product In Stock Save Or update");
		if(invoice.getProductInfo()!=null) {
			int id = invoice.getProductInfo().getId();
			List<ProductInStock> productInStocks = productInStockDAO.findByProperty("productInfo.id", id);
			ProductInStock productInStock = null;
			if(productInStocks!=null && !productInStocks.isEmpty()) {
				productInStock = productInStocks.get(0);
				log.info(" update qty = "+invoice.getQty()+" and price = "+invoice.getPrice());
				if(invoice.getType()==1) {
					productInStock.setQty(productInStock.getQty()+invoice.getQty());
				}
				if(invoice.getType()==2) {
					productInStock.setQty(productInStock.getQty()-invoice.getQty());
				}
				// type = 1 la nhap hang, type = 2 la xuat hang
				if(invoice.getType()==1) {
					productInStock.setPrice(invoice.getPrice());
				}
				productInStock.setUpdateDate(new Date());
				productInStockDAO.update(productInStock);
			}else if(invoice.getType()==1){
				log.info(" insert to stock qty = "+invoice.getQty()+" and price = "+invoice.getPrice());
				productInStock = new ProductInStock();
				ProductInfo productInfo = new ProductInfo();
				productInfo.setId(invoice.getProductInfo().getId());
				productInStock.setProductInfo(productInfo);
				productInStock.setActiveFlag(1);
				productInStock.setCreateDate(new Date());
				productInStock.setUpdateDate(new Date());
				productInStock.setQty(invoice.getQty());
				productInStock.setPrice(invoice.getPrice());
				productInStockDAO.save(productInStock);
			}
		}
	}

}
