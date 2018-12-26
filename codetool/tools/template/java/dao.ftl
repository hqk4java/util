package ${table.daoPackage};

import java.util.List;

import ${table.domainQualifiClassName};
import ${table.voQualifiClassName};
import com.bluedon.common.base.BaseMybatisDao;
import com.bluedon.common.page.Pagination;

import org.apache.ibatis.annotations.Param;

public interface ${table.daoName} extends BaseMybatisDao<${table.domainName},Integer> {	
    
    public void deleteByIds(@Param("ids") List<Integer> ids);
    
    public List<${table.domainName}> selectList(${table.domainName} ${table.domainName?uncap_first});
  
    List<${table.voName}> findListByPage(@Param("vo") ${table.voName} vo,@Param("page")Pagination page);

}
