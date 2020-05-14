package inventory.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import inventory.model.ProductInStock;

@Repository
@Transactional(rollbackFor = Exception.class)
public class ProductInstockDAOImpl extends BaseDAOImpl<ProductInStock> implements ProductInStockDAO<ProductInStock> {

}
